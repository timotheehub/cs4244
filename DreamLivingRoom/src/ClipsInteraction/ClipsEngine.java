/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ClipsInteraction;

import CLIPSJNI.*;
import java.util.ArrayList;
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
        Question question = new Question();
        
        String factsRequest = "(find-all-facts ((?f question)) TRUE)";
        MultifieldValue multifieldValue = (MultifieldValue) clipsEnvironment.eval(factsRequest);

        int listSize = multifieldValue.listValue().size();
        FactAddressValue factAddressValue;
        // Take the first question
        if (listSize >= 1)
        {
             factAddressValue = (FactAddressValue) multifieldValue.listValue().get(0);
             question.setText(factAddressValue.getFactSlot("text").toString());
             question.setQuestionId(factAddressValue.
                     getFactSlot("question-id").toString());
             question.setQuestionType(factAddressValue.
                     getFactSlot("question-type").toString());
             List<PrimitiveValue> listValue = ((MultifieldValue) factAddressValue.getFactSlot("valid-answers")).listValue();
             
             for (PrimitiveValue pValue : listValue)
             {
                question.addAValidAnswer(pValue.getValue().toString());
             }
        }
        System.out.println("(question (question-id "
                + question.getQuestionId() + ") (question-type "
                + question.getQuestionType() + ") (text \""
                + question.getText() + "\"))");

        return question;
    }

    public RoomSize getRoomSize()
    {
        RoomSize size = new RoomSize();

        String factsRequest = "(find-all-facts ((?f room-size)) TRUE)";
        MultifieldValue multifieldValue = (MultifieldValue) clipsEnvironment.eval(factsRequest);

        int listSize = multifieldValue.listValue().size();
        FactAddressValue factAddressValue;
        // Take the first question
        if (listSize >= 1)
        {
             factAddressValue = (FactAddressValue) multifieldValue.listValue().get(0);
             
             size.length = Integer.parseInt(factAddressValue.
                     getFactSlot("length").toString());
             size.width = Integer.parseInt(factAddressValue.
                     getFactSlot("width").toString());
        }

        return size;
    }

    public ArrayList getFurniture()
    {
        ArrayList<Furniture> furnitureList = new ArrayList();

        String factsRequest = "(find-all-facts ((?f furniture-pos)) TRUE)";
        MultifieldValue multifieldValue = (MultifieldValue) clipsEnvironment.eval(factsRequest);

        int listSize = multifieldValue.listValue().size();
        System.out.println(listSize);
        FactAddressValue factAddressValue;
        // Take the first question
        if (listSize >= 1)
        {
            for (int i = 0; i < listSize; i++) {
             factAddressValue = (FactAddressValue) multifieldValue.listValue().get(i);
             Furniture furniturePos = new Furniture();
             furniturePos.setFurnitureId(factAddressValue.
                     getFactSlot("fid").toString());

             furniturePos.setToRight(Integer.parseInt(factAddressValue.
                     getFactSlot("toright").toString()));
             furniturePos.setToLeft(Integer.parseInt(factAddressValue.
                     getFactSlot("toleft").toString()));
             furniturePos.setToTop(Integer.parseInt(factAddressValue.
                     getFactSlot("totop").toString()));
             furniturePos.setToBottom(Integer.parseInt(factAddressValue.
                     getFactSlot("tobottom").toString()));
             System.out.println("(furniture-pos (fid "
                + furniturePos.getFurnitureId() + ") (toRight "
                + furniturePos.getToRight() + ") (toLeft "
                + furniturePos.getToLeft() + ") (toTop "
                + furniturePos.getToTop() + ") (toBottom "
                + furniturePos.getToBottom() + "))");
             furnitureList.add(furniturePos);
            }
        }

        

        return furnitureList;
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
