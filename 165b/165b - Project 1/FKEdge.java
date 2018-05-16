//This class was created by Kevin Thai, Emmeline Tsen, and Amanda Ho. Please do not use this class without the written consent from these individuals.

package zest;

public class FKEdge {
	String start;
	String end;
	
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	@Override
	public String toString() {
		return "FKEdge [start=" + start + ", end=" + end + "]";
	}
	
	
}
