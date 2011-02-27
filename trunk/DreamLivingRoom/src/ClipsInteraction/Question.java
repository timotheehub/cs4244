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
    private String text;
    private List<String> validAnswers;

    public Question()
    {
        questionId = "";
        text = "";
        validAnswers = new ArrayList<String>();
    }

    public String getQuestionId() {
        return questionId;
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

    public void setText(String text) {
        // remove the quotes
        this.text = text.substring(1, text.length() - 1);
    }

    public void setValidAnswers(List<String> validAnswers) {
        this.validAnswers = validAnswers;
    }

    public void addAValidAnswer(String validAnswer) {
        validAnswers.add(validAnswer);
    }
}
