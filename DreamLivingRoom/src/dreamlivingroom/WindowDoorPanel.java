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

    private Image[] windowImages;
    private Image[] doorImages;
    int[] windowX, windowY, doorX, doorY;
    int mouseX, mouseY;
    int selected;
    int roomLength, roomWidth;
    int plotLength, plotWidth;
    MainFrame container;
    Rectangle layout;
    int numImages = 1;
    double ratio;

    Question currentQuestion;
    ClipsEngine clips;

    /** Creates new form WindowDoorPanel */
    public WindowDoorPanel(MainFrame mainFrame) {
        container = mainFrame;
        this.clips = container.getClips();
        currentQuestion = null;
        roomLength = container.getRoomLength();
        roomWidth = container.getRoomWidth();
        windowImages = new Image[numImages];
        doorImages = new Image[numImages];
        windowX = new int[numImages];
        windowY = new int[numImages];
        doorX = new int[numImages];
        doorY = new int[numImages];
        for(int i = 0; i<numImages; i++) {
            windowX[i] = 10;
            windowY[i] = 100;
            doorX[i] = 10;
            doorY[i] = 150;
        }
        initComponents();
        textLabel.setText("Please drag the window and door to proper positions.");
        submitButton.setText("Submit");
        submitButton.addActionListener(new ButtonListener());
        
        backButton.setText("Back");
        backButton.addActionListener(new ButtonListener());
        try{
            for(int i = 0; i< numImages; i++) {
                windowImages[i] = ImageIO.read(new File("window.jpg"));
                doorImages[i] = ImageIO.read(new File("door.jpg"));
            }
        } catch(IOException ex) {
            System.out.println("Unable to fetch image");
            System.exit(0);
        }
        
        MediaTracker mt = new MediaTracker(this);
        for(int i=0;i<numImages; i++) {
            mt.addImage(windowImages[i],1);
            mt.addImage(doorImages[i],1); 
        }
        
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
            for (int i = 0; i < numImages; i++) {
                if (within(windowX[i], windowY[i], 40, 40, mouseX, mouseY)) {
                    selected = i;
                    break;
                } else if (within(doorX[i], doorY[i], 40, 40, mouseX, mouseY)) {
                    selected = 10+i;
                    break;
                } else {
                    selected = -1;
                }
            }
        }
    }
    
    class ButtonListener implements ActionListener {
        public void actionPerformed(ActionEvent e) {
            if(e.getActionCommand().equals("Submit")) {
              //  frame.initQuestionPanel();
                if ((currentQuestion != null))
                {
                    if((!layout.contains(windowX[0],windowY[0]) && layout.contains(windowX[0]+40,windowY[0]+40)) ||
                            (layout.contains(windowX[0],windowY[0]) && !layout.contains(windowX[0]+40,windowY[0]+40))) {
                        int toleft = 0;
                        int toright = 0;
                        int totop = 0;
                        int tobottom = 0;
                        //The left side
                        if(windowX[0] <= 60) {
                            toleft = 0;
                        } else {
                            toleft = (int)((windowX[0]-60)*ratio);
                        }
                        //The right side
                        if(windowX[0]+40>=plotLength+60) {
                            toright = 0;
                        } else{
                            toright = (int)((plotLength+60-(windowX[0]+40))*ratio);
                        }
                        //The top
                        if(windowY[0] <= 60) {
                            totop = 0;
                        } else{
                            totop = (int)((windowY[0]-60)*ratio);
                        }
                        //The bottom
                        if(windowY[0]+40>=plotWidth+60) {
                            tobottom = 0;
                        } else{
                            tobottom = (int)((plotWidth+60-(windowY[0]+40))*ratio);
                        }
                        Answer answer = new Answer(currentQuestion.getQuestionId(),"window-l",Integer.toString(toleft));
                        clips.setAnswer(answer);
                        answer = new Answer(currentQuestion.getQuestionId(),"window-r",Integer.toString(toright));
                        clips.setAnswer(answer);
                        answer = new Answer(currentQuestion.getQuestionId(),"window-t",Integer.toString(totop));
                        clips.setAnswer(answer);
                        answer = new Answer(currentQuestion.getQuestionId(),"window-b",Integer.toString(tobottom));
                        clips.setAnswer(answer);
                    } else {
                        System.out.println("Please place the window image at the proper places.");
                    }
                    
                    if((!layout.contains(doorX[0],doorY[0]) && layout.contains(doorX[0]+40,doorY[0]+40)) ||
                            (layout.contains(doorX[0],doorY[0]) && !layout.contains(doorX[0]+40,doorY[0]+40))) {
                        int toleft = 0;
                        int toright = 0;
                        int totop = 0;
                        int tobottom = 0;
                        //The left side
                        if(doorX[0] <= 60) {
                            toleft = 0;
                        } else {
                            toleft = (int)((doorX[0]-60)*ratio);
                        }
                        //The right side
                        if(doorX[0]+40>=plotLength+60) {
                            toright = 0;
                        } else{
                            toright = (int)((plotLength+60-(doorX[0]+40))*ratio);
                        }
                        //The top
                        if(doorY[0] <= 60) {
                            totop = 0;
                        } else{
                            totop = (int)((doorY[0]-60)*ratio);
                        }
                        //The bottom
                        if(doorY[0]+40>=plotWidth+60) {
                            tobottom = 0;
                        } else{
                            tobottom = (int)((plotWidth+60-(doorY[0]+40))*ratio);
                        }
                        Answer answer = new Answer(currentQuestion.getQuestionId(),"door-l",Integer.toString(toleft));
                        clips.setAnswer(answer);
                        answer = new Answer(currentQuestion.getQuestionId(),"door-r",Integer.toString(toright));
                        clips.setAnswer(answer);
                        answer = new Answer(currentQuestion.getQuestionId(),"door-t",Integer.toString(totop));
                        clips.setAnswer(answer);
                        answer = new Answer(currentQuestion.getQuestionId(),"door-b",Integer.toString(tobottom));
                        clips.setAnswer(answer);
                    } else {
                        System.out.println("Please place the door image at the proper places.");
                    }
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
            int tempX = e.getX();
            int tempY = e.getY();

            if(selected<0)
            {
                ;
            }
            else if(selected<10){
                windowX[selected] = windowX[selected] +tempX-mouseX;
                windowY[selected] = windowY[selected] + tempY-mouseY;
            }
            else if(selected>=10) {
                doorX[selected-10] = doorX[selected-10]+tempX-mouseX;
                doorY[selected-10] = doorY[selected-10]+tempY-mouseY;
            }
            mouseX = tempX;
            mouseY = tempY;
            repaint();
        }
        
        
    }
    
    void createLayout() {
        int plotableLength = this.getWidth() - 70;
        int plotableWidth = this.getHeight() - 70;
        // System.out.println(plotableLength+" "+plotableWidth);
        // System.out.println(roomLength +" " + roomWidth);
        ratio = Math.max((double)roomLength/plotableLength, (double)roomWidth/plotableWidth);
        // System.out.println(ratio);
        plotLength = (int) (roomLength/ratio);
        plotWidth = (int) (roomWidth/ratio);
        // System.out.println(plotLength + " " + plotWidth);
        layout = new Rectangle(60,60,plotLength,plotWidth);
    }
    
    @Override
    public void paintComponent(Graphics g) {
        super.paintComponent(g);
        createLayout();
        Graphics2D g2D = (Graphics2D) g;
        g2D.draw(layout);
        
        for(int i=0;i<numImages;i++){
            g.drawImage(windowImages[i], windowX[i],windowY[i],40,40, this);
            g.drawImage(doorImages[i], doorX[i], doorY[i],40,40, this);
        }
        
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
