/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package dreamlivingroom;

/**
 *
 * @author ZandyJack
 */
import java.awt.*;
import javax.swing.*;
import java.awt.event.*;

public class SizePanel extends JPanel{

    JTextField lengthPanel;
    JTextField widthPanel;
    //JDesktopPane desk;
    JPanel layout;
    MainFrame container;

    public SizePanel(MainFrame frame) {
        //desk = new JDesktopPane();
        layout = new JPanel();
        lengthPanel = new JTextField(10);
        widthPanel = new JTextField(10);
        container = frame;
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

    class ButtonListener implements ActionListener {
        public void actionPerformed(ActionEvent e) {
            if (e.getActionCommand().equals("Update")) {
                String inputLength = lengthPanel.getText();
                String inputWidth = widthPanel.getText();
                if(inputLength.matches("^-?\\d+(\\.\\d+)?$") && inputWidth.matches("^-?\\d+(\\.\\d+)?$")){
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
                if(inputLength.matches("^-?\\d+(\\.\\d+)?$") && inputWidth.matches("^-?\\d+(\\.\\d+)?$")){
                    container.setRoomLength((int)(Double.parseDouble(lengthPanel.getText()))*1000);
                    container.setRoomWidth((int)(Double.parseDouble(widthPanel.getText()))*1000);
                    container.initWindowDoorPanel();
                }
            }
        }
    }
}

