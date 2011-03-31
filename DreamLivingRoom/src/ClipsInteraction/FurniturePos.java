/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ClipsInteraction;

/**
 *
 * @author ZandyJack
 */
public class FurniturePos {
    private String furnitureId;
    private int toLeft;
    private int toRight;
    private int toBottom;
    private int toTop;
    private String orientation;

    public FurniturePos() {
        furnitureId = "";
        toLeft = 0;
        toRight = 0;
        toBottom = 0;
        toTop = 0;
        orientation = "";
    }

    public String getFurnitureId() {
        return furnitureId;
    }

    public void setFurnitureId(String id) {
        furnitureId = id;
    }

    public Integer getToRight() {
        return toRight;
    }

    public void setToRight(int value) {
        toRight = value;
    }

    public Integer getToLeft() {
        return toLeft;
    }

    public void setToLeft(int value) {
        toLeft = value;
    }

    public Integer getToBottom() {
        return toBottom;
    }

    public void setToBottom(int value) {
        toBottom = value;
    }

    public Integer getToTop() {
        return toTop;
    }

    public void setToTop(int value) {
        toTop = value;
    }

    public String getOrientation() {
        return orientation;
    }

    public void setOrientation(String orientation) {
        this.orientation = orientation;
    }
}
