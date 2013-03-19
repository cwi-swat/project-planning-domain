module systems::openpm::INTMapping

import Meta::Mapping;

public ModelMappings openpmINTMapping = {
	equalName("User", "User")
	, equalName("Product", "Product")
	, equalName("Task", "Task")
	, synonym("Sprint", "Iteration")
	, equalName("Effort", "Effort")
	, equalName("Attachment", "Attachment")
	, equalName("Tab", "Tab")
	, equalName("Splitter", "Splitter")
	, equalName("TaskType", "Type")
	, equalName("TaskState", "State")
	, equalName("Link", "Link")
	, equalName("Label", "Label")
	, equalName("TaskButton", "Button")
	, equalName("Access", "Access Right")
	, synonym("ObjectVersion", "ObjectHistory")
	, synonym("FieldVersion", "FieldHistory")
	, equalName("Event", "HistoryEvent")
	, equalName("Create", "Create")
	, equalName("Update", "Update")
	, equalName("Delete", "Delete")
	, equalName("Comment", "Comment")
	, synonym("EmailSubscription", "Email Notification")
};



public ModelMappingFailures openpmINTMappingFailures = {
	missing("Milestone", "In the source a milestone was explained, but not in the UI")
	, implementation("EmailSubscriptionType","Sending emails to users is implementation details of a electronic systeSending emails to users is implementation details of a electronic systemm")
	, *implementation({"Add", "Remove",  "ObjectType", "FieldType"},"This part of the Temporal Object/Property pattern, was not visible.")
};