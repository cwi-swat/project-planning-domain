module systems::openpm::UIInternalMapping

import Model::Mapping;

public ModelMappings openpmMapping = {
	equalName("User", "User")
	, equalName("Product", "Product")
	, equalName("Task", "Task")
	, synonym("Iteration", "Sprint")
	, equalName("Effort", "Effort")
	, equalName("Attachment", "Attachment")
	, equalName("Tab", "Tab")
	, equalName("Splitter", "Splitter")
	, equalName("Type", "TaskType")
	, equalName("State", "TaskState")
	, equalName("Link", "Link")
	, equalName("Label", "Label")
	, equalName("Button", "TaskButton")
	, equalName("Access Right", "Access")
	, synonym("ObjectHistory", "ObjectVersion")
	, synonym("FieldHistory", "FieldVersion")
	, equalName("HistoryEvent", "Event")
	, equalName("Create", "Create")
	, equalName("Update", "Update")
	, equalName("Delete", "Delete")
	, equalName("Comment", "Comment")
	, synonym("Email Notification", "EmailSubscription")
};



public ModelMappingFailures openpmFailures = {
	missing("Milestone", "In the source a milestone was explained, but not in the UI")
	, implementation("EmailSubscriptionType","Sending emails to users is implementation details of a electronic systeSending emails to users is implementation details of a electronic systemm")
	, *implementation({"Add", "Remove",  "ObjectType", "FieldType"},"This part of the Temporal Object/Property pattern, was not visible.")
};