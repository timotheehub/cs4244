/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * QuestionFrame.java
 *
 * Created on Feb 27, 2011, 9:01:52 PM
 */

package dreamlivingroom;

import ClipsInteraction.ClipsEngine;
import ClipsInteraction.Question;
import ClipsInteraction.RoomSize;

/**
 *
 * @author Standard
 */
public class MainFrame extends javax.swing.JFrame {
    private RoomSize roomSize;
    private ClipsEngine clips;


    /** Creates new form QuestionFrame */
    public MainFrame() {
        initComponents();
        mainPanel = null;
        roomSize = new RoomSize();
        clips = new ClipsEngine("CS4244.clp");
    }
    
    int getRoomLength() {
        return roomSize.length;
    }
    
    int getRoomWidth() {
        return roomSize.width;
    }

    public ClipsEngine getClips() {
        return clips;
    }

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 400, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 300, Short.MAX_VALUE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    /**
    * @param args the command line arguments
    */
    public static void main(String args[]) {
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                MainFrame mainFrame = new MainFrame();
                mainFrame.setVisible(true);
                mainFrame.RunClips();
            }
        });
    }

    private void initSizePanel()
    {
        if (mainPanel != null)
        {
            mainPanel.setVisible(false);
        }
        mainPanel = new SizePanel(this);
        mainPanel.setSize(600,400);
        add(mainPanel);
        this.setSize(mainPanel.getWidth()+20,mainPanel.getHeight()+40);
        this.repaint();
    }
    
    private void initWindowDoorPanel()
    {
        if (mainPanel != null)
        {
            mainPanel.setVisible(false);
        }
        mainPanel = new WindowDoorPanel(this);
        mainPanel.setSize(600,400);
        add(mainPanel);
        this.repaint();
    }
    
    private void initQuestionPanel()
    {
        if (mainPanel != null)
        {
            mainPanel.setVisible(false);
        }
        mainPanel = new QuestionPanel(this);
        mainPanel.setSize(300,400);
        add(mainPanel);
        repaint();
    }

     private void initPictureDisplayPanel() {
          if (mainPanel != null)
        {
            mainPanel.setVisible(false);
        }
        mainPanel = new PictureDisplayPanel(this);
        mainPanel.setSize(600,400);
        add(mainPanel);
        repaint();
    }
     
    public void RunClips()
    {
        Question question;
        clips.runEnvironment();
        question = clips.getQuestion();
        // System.out.println(question.getQuestionType());

        if ((question.getQuestionType().equals("list"))
            || (question.getQuestionType().equals("preference")))
        {
            initQuestionPanel();
            ((QuestionPanel)mainPanel).setQuestion(question);
        }
        else if (question.getQuestionType().equals("size"))
        {
            initSizePanel();
            ((SizePanel)mainPanel).setQuestion(question);
        }
        else if (question.getQuestionType().equals("window-door"))
        {
            roomSize = clips.getRoomSize();
            initWindowDoorPanel();
            ((WindowDoorPanel)mainPanel).setQuestion(question);
        }
        else if (question.getQuestionType().equals("furniture-preference"))
        {
            initPictureDisplayPanel();
            ((PictureDisplayPanel)mainPanel).setQuestion(question);
        }
        else if (question.getQuestionType().equals(""))
        {
            System.out.println("Bye!");
            System.exit(0);
        }
    }

    private javax.swing.JPanel mainPanel;

   
    // Variables declaration - do not modify//GEN-BEGIN:variables
    // End of variables declaration//GEN-END:variables

}