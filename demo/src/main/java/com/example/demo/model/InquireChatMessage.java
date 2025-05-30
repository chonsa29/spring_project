package com.example.demo.model;

public class InquireChatMessage {
	
	private String sender;
    private String message;
    
    public InquireChatMessage() {}

    public InquireChatMessage(String sender, String message) {
    	this.sender = sender;
        this.message = message;
    }

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
