/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package dreamlivingroom;

/**
 *
 * @author ZandyJack
 */
import ClipsInteraction.Answer;
import ClipsInteraction.ClipsEngine;
import ClipsInteraction.Question;
import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class SizePanel extends JPanel{

    JTextField lengthPanel;
    JTextField widthPanel;
    JPanel layout;
    MainFrame container;

    Question currentQuestion;
    ClipsEngine clips;

    public SizePanel(MainFrame mainFrame) {
        container = mainFrame;
        this.clips = container.getClips();
        currentQuestion = null;
        layout = new JPanel();
        lengthPanel = new JTextField(10);
        widthPanel = new JTextField(10);
        //container = frame;
        JButton lengthButton = new JButton("Update");
        lengthButton.setVerticalTextPosition(AbstractButton.CENTER);
        lengthButton.setHorizontalTextPosition(AbstractButton.LEADING); //aka LEFT, for left-to-right locales
        lengthButton.addActionListener(new ButtonListener());
        JButton submitButton = new JButton("Submit");
        submitButton.setVerticalTextPosition(AbstractButton.CENTER);
        submitButton.setHorizontalTextPosition(AbstractButton.LEADING);
        submitButton.addActionListener(new ButtonListener());
        add(new JLabel("Length (m)"));
        add(lengthPanel);
        add(new JLabel("Width (m)"));
        add(widthPanel);
        add(lengthButton);
        add(submitButton);
    }

    public void setQuestion(Question question)
    {
        currentQuestion = question;
    }

    class ButtonListener implements ActionListener {
        public void actionPerformed(ActionEvent e) {
            if (e.getActionCommand().equals("Update")) {
                String inputLength = lengthPanel.getText();
                String inputWidth = widthPanel.getText();
                if(inputLength.matches("^-?\\d{1,5}(\\.\\d+)?$") && inputWidth.matches("^-?\\d{1,5}(\\.\\d+)?$")){
                    int length = (int)(Double.parseDouble(inputLength)*1000);
                    int width= (int)(Double.parseDouble(inputWidth)*1000);
                    int plotableLength = 600 - 40;
                    int plotableWidth = 400 - 100;
                    //System.out.println(plotableLength + " "  + plotableWidth);
                    double ratio = Math.max((double)length/plotableLength,(double)width/plotableWidth);
                    //System.out.println(ratio);
                    int plotLength = (int)(length/ratio);
                    int plotWidth = (int)(width/ratio);
                    //System.out.println(plotLength + " " + plotWidth);
                    layout.setBounds(20+(plotableLength-plotLength)/2, 50+(plotableWidth-plotWidth)/2, plotLength, plotWidth);
                    layout.setBorder(BorderFactory.createLineBorder(Color.black));
                    add(layout);
                    repaint();
                }
            }
            else if(e.getActionCommand().equals("Submit")) {
                String inputLength = lengthPanel.getText();
                String inputWidth = widthPanel.getText();
                if(inputLength.matches("^-?\\d{1,5}(\\.\\d+)?$") && inputWidth.matches("^-?\\d{1,5}(\\.\\d+)?$")
                        && currentQuestion != null){
                   // container.setRoomLength((int)(Double.parseDouble(lengthPanel.getText()))*1000);
                  //  container.setRoomWidth((int)(Double.parseDouble(widthPanel.getText()))*1000);
                  //  container.initWindowDoorPanel();
                    Answer answer = new Answer(currentQuestion.getQuestionId(),
                    "room-width", Integer.toString((int)Double.parseDouble(inputWidth)*1000));
                    clips.setAnswer(answer);
                    answer = new Answer(currentQuestion.getQuestionId(),
                    "room-length", Integer.toString((int)Double.parseDouble(inputLength)*1000));
                    clips.setAnswer(answer);
                    container.RunClips();
                }
                else{
                    System.out.println("Only 5 digits is allowed.");
                }
            }
        }
    }
}

