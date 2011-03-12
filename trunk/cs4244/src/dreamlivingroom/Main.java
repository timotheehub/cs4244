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

public class Main extends JPanel{

    JTextField lengthPanel;
    JTextField widthPanel;
    //JDesktopPane desk;
    JPanel layout;

    public Main() {
        //desk = new JDesktopPane();
        layout = new JPanel();
        lengthPanel = new JTextField(20);
        widthPanel = new JTextField(20);
        JButton lengthButton = new JButton("Click Me Double Times");
        lengthButton.setVerticalTextPosition(AbstractButton.CENTER);
        lengthButton.setHorizontalTextPosition(AbstractButton.LEADING); //aka LEFT, for left-to-right locales
        lengthButton.addActionListener(new ButtonListener());
        add(new JLabel("Length"));
        add(lengthPanel);
        add(new JLabel("Width"));
        add(widthPanel);
        add(lengthButton);
    }
    public static void main(String[] args) {
        JFrame f = new JFrame("DreamLivingRoom");
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        f.getContentPane().add(new Main());
        f.setSize(600,300);
        f.setVisible(true);
        
    }

    class ButtonListener implements ActionListener {
        public void actionPerformed(ActionEvent e) {
            if (e.getActionCommand().equals("Click Me Double Times")) {
                int length = Integer.parseInt(lengthPanel.getText());
                int width= Integer.parseInt(lengthPanel.getText());
                layout.setBounds(60, 60, length, width);
                layout.setBorder(BorderFactory.createLineBorder(Color.black));
                add(layout);
                repaint();
            }
        }
    }
}

