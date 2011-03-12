/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ClipsInteraction;

/**
 *
 * @author Standard
 */
public class Answer {
    private String questionId;
    private String name;
    private String value;

    public Answer()
    {
        questionId = "";
        name = "";
        value = "";
    }

    public Answer(String questionId, String name, String value) {
        this.questionId = questionId;
        this.name = name;
        this.value = value;
    }

    public String getName() {
        return name;
    }

    public String getQuestionId() {
        return questionId;
    }

    public String getValue() {
        return value;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setQuestionId(String questionId) {
        this.questionId = questionId;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
