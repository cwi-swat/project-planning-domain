module systems::openpm::UIModel

import Model::MetaDomain;

public DomainModel openpmUI = {
	class("Task", [
		asso("has", "State", "Task-Details")
		, asso("has", "Type", "Task-Details")
		, asso("has", "Label", "Task-Details")
		, asso("has", "Effort", "Task-Details")
		, asso("has", "User", "Task-Details")
		, asso("has", "Attachment", "Task-Details")
		, asso("has", "TaskHistory", "Task-Details")
		, asso("has", "Comment", "Task-Details")
		], "Task-Details")
	, class("Label", "Label-New")
	, class("Comment", "Task-Details")
	
	, class("TaskHistory", [
		asso("has", "FieldHistory", "Task-Details")	
		, asso("by", "User", "Task-Details")	
	], "Task-Details")
	
	, class("FieldHistory", [
		asso("happend", "HistoryEvent", "Task-Details")	
	], "Task-Details")
	
	, class("HistoryEvent", "Task-Details")
	
	, class("Product", [
		asso("has", "Task", "Task-Details")	
		, asso("part of", "Iteration", "Product-new")	
		, asso("has", "Link", "Product-new")	
		, asso("access", "user", "Product-new")[@class="Access Right"]	
		], {"Task-Details", "Product-new"})
		
	, class("Access Right", [
		], "Product-new")
		
	, class("User", [
		asso("member of", "Email Notification", "User-new")	
		], "User-new")
		
	, class("Email Notification", "User-new")
		
	, class("Splitter", [asso("for", "Type", "Splitter-Edit")], "Splitter-Edit")
	, class("Tab", [
			asso("has", "Splitter", "Splitter-Edit")	
		], {"Splitter-Edit", "Tab-Edit"})
	, class("State", [
		asso("valid for", "Type" , "State-new")
		], "State-new")
	
	, class("Button", [
		asso("from", "State", "Button-new")
		, asso("to", "State", "Button-new")
		, asso("valid for", "Type" , "Button-new")
		], "Button-new")
	, class("Effort", "Effort")
	, class("Type", "State")
	, class("Iteration", "Product-new")
	, class("Link", "Product-new")
	, class("Attachment", "Task-new")
};