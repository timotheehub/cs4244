/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * WindowDoorPanel.java
 *
 * Created on Feb 28, 2011, 5:35:19 PM
 */

package dreamlivingroom;

import ClipsInteraction.Answer;
import ClipsInteraction.ClipsEngine;
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
import java.awt.event.MouseMotionAdapter;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;

/**
 *
 * @author caofan
 */
public class WindowDoorPanel extends javax.swing.JPanel {

    private Image windowImages;
    private Image doorImages;
    int windowX, windowY, doorX, doorY;
    int mouseX, mouseY;
    int selected;
    int roomLength, roomWidth;
    MainFrame container;
    Rectangle layout;
    final int WINDOW_LENGTH = 800; // in millimeters
    final int WINDOW_WIDTH = 100;
    final int DOOR_LENGTH = 800;
    final int DOOR_WIDTH = 100;

    Question currentQuestion;
    ClipsEngine clips;

    /** Creates new form WindowDoorPanel */
    public WindowDoorPanel(MainFrame mainFrame) {
        container = mainFrame;
        this.clips = container.getClips();
        currentQuestion = null;
        roomLength = container.getRoomLength();
        roomWidth = container.getRoomWidth();
        windowX = 10;
        windowY = 100;
        doorX = 10;
        doorY = 150;
        initComponents();
        textLabel.setText("Please drag the window and door to proper positions.");
        submitButton.setText("Submit");
        submitButton.addActionListener(new ButtonListener());
        
        backButton.setText("Back");
        backButton.addActionListener(new ButtonListener());
        try{
            windowImages = ImageIO.read(new File("window.jpg"));
            doorImages = ImageIO.read(new File("door.jpg"));
        } catch(IOException ex) {
            System.out.println("Unable to fetch image");
            System.exit(0);
        }
        
        MediaTracker mt = new MediaTracker(this);
        mt.addImage(windowImages,1);
        mt.addImage(doorImages,1); 
        
        try {
            mt.waitForAll();
        } catch(Exception e) {
            System.out.println("Exception while loading image.");
            System.exit(0);
        }
        
        addMouseListener(new MyMouseListener());
        addMouseMotionListener(new MyMouseMotionListener());
    }

    public void setQuestion(Question question)
    {
        currentQuestion = question;
        textLabel.setText(question.getText());
    }
    
    class MyMouseListener extends MouseAdapter {
        @Override
        public void mousePressed(MouseEvent e) {
            mouseX = e.getX();
            mouseY = e.getY();
            if (within(windowX, windowY, 40, 40, mouseX, mouseY)) {
                selected = 0;
            } else if (within(doorX, doorY, 40, 40, mouseX, mouseY)) {
                selected = 10;
            } else {
                selected = -1;
            }
        }

        @Override
        public void mouseReleased(MouseEvent e) {
            int [] tempCoordinates = new int[2]; // x and y

            if((selected >=0) && (selected<10)
            && (isMouseOnAWall(windowX + e.getX() - mouseX,
                windowY + e.getY() - mouseY, tempCoordinates))){
                windowX = tempCoordinates[0];
                windowY = tempCoordinates[1];
            }
            else if((selected>=10)
                && (isMouseOnAWall(doorX + e.getX() - mouseX,
                    doorY + e.getY() - mouseY, tempCoordinates))){
                doorX = tempCoordinates[0];
                doorY = tempCoordinates[1];
            }

            mouseX = e.getX();
            mouseY = e.getY();
            repaint();
        }
    }
    
    class ButtonListener implements ActionListener {
        public void actionPerformed(ActionEvent e) {
            if(e.getActionCommand().equals("Submit")) {
              //  frame.initQuestionPanel();
                if ((currentQuestion != null) && (windowX > 10) && (doorX > 10))
                {
                    // Compute the size of the window
                    String windowOrientation = getOrientation(windowX, windowY);
                    String doorOrientation = getOrientation(doorX, doorY);
                    int windowSizeX = 0;
                    int windowSizeY = 0;
                    int doorSizeX = 0;
                    int doorSizeY = 0;
                    if (windowOrientation.equals("left")
                            || windowOrientation.equals("right"))
                    {
                        windowSizeX = WINDOW_WIDTH;
                        windowSizeY = WINDOW_LENGTH;
                    }
                    else
                    {
                        windowSizeX = WINDOW_LENGTH;
                        windowSizeY = WINDOW_WIDTH;
                    }
                    if (doorOrientation.equals("left")
                            || doorOrientation.equals("right"))
                    {
                        doorSizeX = DOOR_WIDTH;
                        doorSizeY = DOOR_LENGTH;
                    }
                    else
                    {
                        doorSizeX = DOOR_LENGTH;
                        doorSizeY = DOOR_WIDTH;
                    }

                    // Write the answers in CLIPS.
                    Answer answer = new Answer(currentQuestion.getQuestionId(),
                        "window-toleft", getToLeft(windowX, windowSizeX));
                    clips.setAnswer(answer);
                    answer = new Answer(currentQuestion.getQuestionId(),
                        "window-toright", getToRight(windowX, windowSizeX));
                    clips.setAnswer(answer);
                    answer = new Answer(currentQuestion.getQuestionId(),
                        "window-totop", getToTop(windowY, windowSizeY));
                    clips.setAnswer(answer);
                    answer = new Answer(currentQuestion.getQuestionId(),
                        "window-tobottom", getToBottom(windowY, windowSizeY));
                    clips.setAnswer(answer);
                    answer = new Answer(currentQuestion.getQuestionId(),
                        "window-orientation", windowOrientation);
                    clips.setAnswer(answer);
                    answer = new Answer(currentQuestion.getQuestionId(),
                        "door-toleft", getToLeft(doorX, doorSizeX));
                    clips.setAnswer(answer);
                    answer = new Answer(currentQuestion.getQuestionId(),
                        "door-toright", getToRight(doorX, doorSizeX));
                    clips.setAnswer(answer);
                    answer = new Answer(currentQuestion.getQuestionId(),
                        "door-totop", getToTop(doorY, doorSizeY));
                    clips.setAnswer(answer);
                    answer = new Answer(currentQuestion.getQuestionId(),
                        "door-tobottom", getToBottom(doorY, doorSizeY));
                    clips.setAnswer(answer);
                    answer = new Answer(currentQuestion.getQuestionId(),
                        "door-orientation", doorOrientation);
                    clips.setAnswer(answer);
                    container.RunClips();
                }
            }
        }
    }
    
    boolean within (int x, int y, int length, int width, int currX, int currY) {
        return x<=currX&&y<=currY&&currX<=x+length&&currY<y+width;
    }
    class MyMouseMotionListener extends MouseMotionAdapter {
        @Override
        public void mouseDragged(MouseEvent e) {
            if((selected >=0) && (selected<10)){
                windowX = windowX + e.getX() - mouseX;
                windowY = windowY + e.getY() - mouseY;
            }
            else if(selected>=10){
                doorX = doorX + e.getX() - mouseX;
                doorY = doorY + e.getY() - mouseY;
            }

            mouseX = e.getX();
            mouseY = e.getY();
            repaint();
        }
    }

    boolean isMouseOnAWall (int x, int y, int [] objectCoordinates) {
        // Left wall
        if ((x >= (int)layout.getMinX() - 40) && (x <= (int)layout.getMinX())
            && (y >= (int)layout.getMinY() + 1) && (y <= (int)layout.getMaxY() - 40))
        {
            objectCoordinates[0] = (int)layout.getMinX() - 20;
            objectCoordinates[1] = y;
        }
        // Right wall
        else if ((x >= (int)layout.getMaxX() - 40) && (x <= (int)layout.getMaxX())
            && (y >= (int)layout.getMinY() + 1) && (y <= (int)layout.getMaxY() - 40))
        {
            objectCoordinates[0] = (int)layout.getMaxX() - 20;
            objectCoordinates[1] = y;
        }
        // Top wall
        else if ((x >= (int)layout.getMinX() + 1) && (x <= (int)layout.getMaxX() - 40)
            && (y >= (int)layout.getMinY() - 40) && (y <= (int)layout.getMinY()))
        {
            objectCoordinates[0] = x;
            objectCoordinates[1] = (int)layout.getMinY() - 20;
        }
        // Bottom wall
        else if ((x >= (int)layout.getMinX() + 1) && (x <= (int)layout.getMaxX() - 40)
            && (y >= (int)layout.getMaxY() - 40) && (y <= (int)layout.getMaxY()))
        {
            objectCoordinates[0] = x;
            objectCoordinates[1] = (int)layout.getMaxY() - 20;
        }
        // Initial position
        else
        {
            objectCoordinates[0] = 10;
            objectCoordinates[1] = 100;
        }
        return true;
    }

     String getOrientation (int x, int y) {
        String s = "noOrientation";
        // Left wall
        if ((x >= (int)layout.getMinX() - 40) && (x <= (int)layout.getMinX())
            && (y >= (int)layout.getMinY() + 1) && (y <= (int)layout.getMaxY() - 40))
        {
            s = "left";
        }
        // Right wall
        else if ((x >= (int)layout.getMaxX() - 40) && (x <= (int)layout.getMaxX())
            && (y >= (int)layout.getMinY() + 1) && (y <= (int)layout.getMaxY() - 40))
        {
            s = "right";
        }
        // Top wall
        else if ((x >= (int)layout.getMinX() + 1) && (x <= (int)layout.getMaxX() - 40)
            && (y >= (int)layout.getMinY() - 40) && (y <= (int)layout.getMinY()))
        {
            s = "top";
        }
        // Bottom wall
        else if ((x >= (int)layout.getMinX() + 1) && (x <= (int)layout.getMaxX() - 40)
            && (y >= (int)layout.getMaxY() - 40) && (y <= (int)layout.getMaxY()))
        {
            s = "bottom";
        }
        return s;
    }

    String getToLeft(int x, int size)
    {
        return Integer.toString(
                (int)((x - layout.getMinX() + 20)
                    *roomLength/(layout.getMaxX() - layout.getMinX()))
                    - size/2);
    }

    String getToRight(int x, int size)
    {
        return Integer.toString(
                (int)((layout.getMaxX() - x - 20)
                    *roomLength/(layout.getMaxX() - layout.getMinX()))
                    - size/2);
    }

    String getToTop(int y, int size)
    {
        return Integer.toString(
                (int)((y - layout.getMinY() + 20)
                    *roomLength/(layout.getMaxY() - layout.getMinY()))
                    - size/2);
    }

    String getToBottom(int y, int size)
    {
        return Integer.toString(
                (int)((layout.getMaxY() - y - 20)
                    *roomLength/(layout.getMaxY() - layout.getMinY()))
                    - size/2);
    }
    
    void createLayout() {
        int plotableLength = this.getWidth() - 170;
        int plotableWidth = this.getHeight() - 70;
        // System.out.println(plotableLength+" "+plotableWidth);
        // System.out.println(roomLength +" " + roomWidth);
        double ratio = Math.max((double)roomLength/plotableLength, (double)roomWidth/plotableWidth);
        // System.out.println(ratio);
        int plotLength = (int) (roomLength/ratio);
        int plotWidth = (int) (roomWidth/ratio);
        // System.out.println(plotLength + " " + plotWidth)
        layout = new Rectangle(60+(plotableLength-plotLength)/2, 50+(plotableWidth-plotWidth)/2,plotLength,plotWidth);
    }
    
    @Override
    public void paintComponent(Graphics g) {
        super.paintComponent(g);
        createLayout();
        Graphics2D g2D = (Graphics2D) g;
        g2D.draw(layout);
        
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

        textLabel.setText("jLabel1");
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
                .addContainerGap(356, Short.MAX_VALUE))
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
