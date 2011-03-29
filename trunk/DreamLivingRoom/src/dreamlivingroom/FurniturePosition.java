/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * FurniturePosition.java
 *
 * Created on Feb 28, 2011, 5:35:19 PM
 */

package dreamlivingroom;

import ClipsInteraction.Answer;
import ClipsInteraction.ClipsEngine;
import ClipsInteraction.Furniture;
import ClipsInteraction.Question;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.MediaTracker;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.image.BufferedImage;
import java.awt.image.ImageObserver;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JLabel;

/**
 *
 * @author Tham Zi Jie
 */
public class FurniturePosition extends javax.swing.JPanel {

    private Image windowImages;
    private Image doorImages;
    int windowX, windowY, doorX, doorY;
    int mouseX, mouseY;
    int roomLength, roomWidth;
    MainFrame container;
    Rectangle layout;
    MediaTracker mt = new MediaTracker(this);
    ArrayList<Furniture> furnitureList;
    ClipsEngine clips;
    Rectangle imageDisplay;

    Question currentQuestion;

    /** Creates new form FurniturePosition */
    public FurniturePosition(MainFrame mainFrame) {
        container = mainFrame;
        this.clips = container.getClips();
        roomLength = container.getRoomLength();
        roomWidth = container.getRoomWidth();
        initComponents();
        textLabel.setText("Result of Layout:");
        submitButton.setText("Submit");
        submitButton.setActionCommand("Submit");
        submitButton.addActionListener(new ButtonListener());
        backButton.setText("Close");
        backButton.setActionCommand("Close");
        backButton.addActionListener(new ButtonListener());

        try{
            windowImages = ImageIO.read(new File("pic/window.jpg"));
            doorImages = ImageIO.read(new File("pic/door.jpg"));
        } catch(IOException ex) {
            System.out.println("Unable to fetch image");
            System.exit(0);
        }        
        
        mt.addImage(windowImages,1);
        mt.addImage(doorImages,1); 
        
        try {
            mt.waitForAll();
        } catch(Exception e) {
            System.out.println("Exception while loading image.");
            System.exit(0);
        }
    }

    public void setQuestion(Question question) {
        currentQuestion = question;
        textLabel.setText(currentQuestion.getText());
        if (currentQuestion.getQuestionType().equals("layout"))
        {
            backButton.setVisible(false);
        }
        else
        {
            submitButton.setVisible(false);
        }
    }

    public void setFurniture(ArrayList furnitureArray) {
        furnitureList = furnitureArray;
    }
    
    class ButtonListener implements ActionListener {
        public void actionPerformed(ActionEvent e) {
            if(e.getActionCommand().equals("Submit")) {
                Answer answer = new Answer(currentQuestion.getQuestionId(),
                        "answer-layout", "0");
                clips.setAnswer(answer);
                try {
                    container.RunClips();
                } catch (IOException ex) {
                    Logger.getLogger(PictureDisplayPanel.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if(e.getActionCommand().equals("Close")) {
                Answer answer = new Answer(currentQuestion.getQuestionId(),
                        "answer-final-layout", "0");
                clips.setAnswer(answer);
                try {
                    container.RunClips();
                } catch (IOException ex) {
                    Logger.getLogger(PictureDisplayPanel.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    //Generate a basic layout of the room
    void createLayout() {
        int plotableLength = this.getWidth() - 170;
        int plotableWidth = this.getHeight() - 70;
        double ratio = Math.max((double)roomLength/plotableLength, (double)roomWidth/plotableWidth);
        int plotLength = (int) (roomLength/ratio);
        int plotWidth = (int) (roomWidth/ratio);
        layout = new Rectangle(60+(plotableLength-plotLength)/2, 50+(plotableWidth-plotWidth)/2,plotLength,plotWidth);
    }

    void drawFurniture(Graphics2D g2D) {
        int plotableLength = this.getWidth() - 170;
        int plotableWidth = this.getHeight() - 70;
        double ratio = Math.max((double)roomLength/plotableLength, (double)roomWidth/plotableWidth)/2;
        //Fetch every furniture from clips source file to display them on the panel
        for (int i = 0; i < furnitureList.size(); ++i) {
            Furniture currentFurniture = furnitureList.get(i);
            int furnitureLength = (int)((roomLength - currentFurniture.getToRight() - currentFurniture.getToLeft())/ratio);
            int furnitureWidth = (int)((roomWidth - currentFurniture.getToTop() - currentFurniture.getToBottom())/ratio);
            //Furniture's size is in mm, so the calculation of the position need to divided by 1000. The additional value is the distance of the layout and the panel
            Rectangle furnitureRectangle = new Rectangle((currentFurniture.getToLeft())/1000+170,(currentFurniture.getToTop())/1000+70,furnitureLength,furnitureWidth);
            String imageName = "pic/" + currentFurniture.getFurnitureId() + ".jpg";
            ImageIcon img = new ImageIcon(imageName);
            JLabel furnitureLabel = new JLabel(scale(img.getImage(),0.1));
            furnitureLabel.setBounds(furnitureRectangle);
            furnitureLabel.addMouseListener(new MyMouseListener(imageName));
            this.add(furnitureLabel);
            g2D.draw(furnitureRectangle);            
        }
    }

    class MyMouseListener extends MouseAdapter {
    String imageName;
    Graphics2D g2D;
    ImageObserver observer;
        private MyMouseListener(String image) {
           imageName = image;
        }
        @Override
        public void mouseClicked(MouseEvent e) {
            //Every time click on a furniture, a new label will overlap another the label to display different furniture
            JLabel displayLabel = new JLabel();
            add(displayLabel);
            displayLabel.setBounds(imageDisplay);
            displayLabel.setIcon(null);
            ImageIcon img = new ImageIcon(imageName);
            displayLabel.setIcon(scale(img.getImage(),0.4));
            displayLabel.setOpaque(true);
        }
    }

    //Function to scale the image
     private ImageIcon scale(Image src, double scale) {
        int w = (int)(scale*src.getWidth(this));
        int h = (int)(scale*src.getHeight(this));
        int type = BufferedImage.TYPE_INT_RGB;
        BufferedImage dst = new BufferedImage(w, h, type);
        Graphics2D g2 = dst.createGraphics();
        g2.drawImage(src, 0, 0, w, h, this);
        g2.dispose();
        return new ImageIcon(dst);
    }

    @Override
    public void paintComponent(Graphics g) {
        super.paintComponent(g);
        createLayout();
        Graphics2D g2D = (Graphics2D) g;
        g2D.draw(layout);
        drawFurniture(g2D);
        imageDisplay = new Rectangle(480,100,110,110);
        g2D.draw(imageDisplay);
        g.drawImage(windowImages, windowX,windowY,40,40, this);
        g.drawImage(doorImages, doorX, doorY,40,40, this);
    }
    

    

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        textLabel = new javax.swing.JLabel();
        submitButton = new javax.swing.JButton();
        backButton = new javax.swing.JButton();

        textLabel.setText("Layout");
        textLabel.setName("textLabel"); // NOI18N

        submitButton.setText("jButton1");
        submitButton.setName("submitButton"); // NOI18N

        backButton.setText("jButton1");
        backButton.setName("backButton"); // NOI18N

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(textLabel)
                .addContainerGap(357, Short.MAX_VALUE))
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap(317, Short.MAX_VALUE)
                .addComponent(backButton)
                .addContainerGap())
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap(317, Short.MAX_VALUE)
                .addComponent(submitButton)
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(textLabel)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 212, Short.MAX_VALUE)
                .addComponent(submitButton)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(backButton)
                .addContainerGap())
        );
    }// </editor-fold>//GEN-END:initComponents


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton backButton;
    private javax.swing.JButton submitButton;
    private javax.swing.JLabel textLabel;
    // End of variables declaration//GEN-END:variables

}
