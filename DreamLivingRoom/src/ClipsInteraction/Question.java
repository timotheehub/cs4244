/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ClipsInteraction;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Standard
 */
public class Question {
    private String questionId;
    private String questionType;
    private String text;
    private List<String> validAnswers;

    public Question()
    {
        questionId = "";
        questionType = "";
        text = "";
        validAnswers = new ArrayList<String>();
    }

    public String getQuestionId() {
        return questionId;
    }

    public String getQuestionType() {
        return questionType;
    }

    public String getText() {
        return text;
    }

    public List<String> getValidAnswers() {
        return validAnswers;
    }

    public void setQuestionId(String questionId) {
        this.questionId = questionId;
    }

    public void setQuestionType(String questionType) {
        this.questionType = questionType;
    }

    public void setText(String text) {
        // remove the quotes
        this.text = text.substring(1, text.length() - 1);
        if (this.text.length() > 40)
        {
            StringBuffer sBuffer = new java.lang.StringBuffer(this.text).insert(0,"<html>");
            sBuffer = sBuffer.insert(sBuffer.length() - 1, "<html>");
            int i = sBuffer.indexOf(" ", 40);
            if ( i >= 40 )
            {
                sBuffer = sBuffer.insert(i, "<br>");
            }
            this.text = sBuffer.toString();
        }
    }

    public void setValidAnswers(List<String> validAnswers) {
        this.validAnswers = validAnswers;
    }

    public void addAValidAnswer(String validAnswer) {
        validAnswers.add(validAnswer);
    }
}
