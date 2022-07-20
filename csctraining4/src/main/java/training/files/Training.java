package training.files;

import java.sql.*;

public class Training {

	String trainingSports, trainingVenue;
	Date startDate, endDate;
	int trainingID;

	public String getTrainingVenue() {
		return trainingVenue;
	}

	public void setTrainingVenue(String trainingVenue) {
		this.trainingVenue = trainingVenue;
	}

	public String getTrainingSports() {
		return trainingSports;
	}

	public void setTrainingSports(String trainingSports) {
		this.trainingSports = trainingSports;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public int getTrainingID() {
		return trainingID;
	}

	public void setTrainingID(int trainingID) {
		this.trainingID = trainingID;
	}

	public Training() {
		// TODO Auto-generated constructor stub
	}

}
