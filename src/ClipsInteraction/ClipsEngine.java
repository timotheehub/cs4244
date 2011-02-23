/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ClipsInteraction;

import CLIPSJNI.*;

/**
 *
 * @author Timothee
 */
public class ClipsEngine {

    Environment clipsEnvironment;

    public ClipsEngine(String fileName)
    {
        clipsEnvironment = new Environment();
        //clipsEnvironment.load(fileName);
        clipsEnvironment.reset();
    }

    public String Run()
    {
        String clipsResult = "";
        
        clipsEnvironment.run();

        String factsRequest = "(find-all-facts ((?f action)) TRUE)";
        MultifieldValue multifieldValue =
                (MultifieldValue) clipsEnvironment.eval(factsRequest);
        int listSize = multifieldValue.listValue().size();
        FactAddressValue factAddressValue;
        for (int i=0; i<listSize; i++)
        {
             factAddressValue = (FactAddressValue) multifieldValue.listValue().get(i);
             clipsResult += factAddressValue.getFactSlot("InsertHereAName").toString();
             clipsResult += "\n";
        }

        clipsEnvironment.reset();
         
        return clipsResult;
    }
}
