/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ClipsInteraction;

import CLIPSJNI.*;
import java.util.List;

/**
 *
 * @author Timothee
 */
public class ClipsEngine {

    Environment clipsEnvironment;

    public ClipsEngine(String fileName)
    {
        clipsEnvironment = new Environment();
        clipsEnvironment.load(fileName);
        clipsEnvironment.reset();
    }

    public void runEnvironment()
    {
        clipsEnvironment.run();
    }

    public void resetEnvironment()
    {
        clipsEnvironment.reset();
    }

    public Question getQuestion()
    {
        Question clipsResult = new Question();
        
        String factsRequest = "(find-all-facts ((?f question)) TRUE)";
        MultifieldValue multifieldValue = (MultifieldValue) clipsEnvironment.eval(factsRequest);

        int listSize = multifieldValue.listValue().size();
        FactAddressValue factAddressValue;
        for (int i=0; i<listSize; i++)
        {
             factAddressValue = (FactAddressValue) multifieldValue.listValue().get(i);
             clipsResult.setText(factAddressValue.getFactSlot("text").toString());
             clipsResult.setQuestionId(factAddressValue.
                     getFactSlot("question-id").toString());
             clipsResult.setQuestionType(factAddressValue.
                     getFactSlot("question-type").toString());
             List<PrimitiveValue> listValue = ((MultifieldValue) factAddressValue.getFactSlot("valid-answers")).listValue();
             
             for (PrimitiveValue pValue : listValue)
             {
                clipsResult.addAValidAnswer(pValue.getValue().toString());
             }
        }

        return clipsResult;
    }

    public void setAnswer(Answer answer)
    {
        clipsEnvironment.assertString("(answer (question-id "
                + answer.getQuestionId() + ") (name "
                + answer.getName() + ") (value "
                + answer.getValue() + "))");
        System.out.println("(answer (question-id "
                + answer.getQuestionId() + ") (name "
                + answer.getName() + ") (value "
                + answer.getValue() + "))");
    }
}
