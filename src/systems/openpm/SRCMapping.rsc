module systems::openpm::SRCMapping

import Meta::Mapping;

public ModelMappings openpmSRCMapping = {
	synonym("User", "Team Member", reason = "Since users are connected to tasks, they are the team members.")
	, extension("Product", "Deliverable", reason="The closest match is the deliverable, but it the Product is actually more than just the deliverable")
	, synonym("Task", "Activity")
	, synonym("Sprint", "Project schedule", reason = "The order of the task are stored in a sprint, and in the task.")
	, equalName("Milestone", "Milestone")
	, synonym("Effort", "Activity duration", reason = "The effort of a task is the time it costs to complete it.")
	, implementationDetail("Attachment", "Activity Attribute", reason = "Attachments contain extra attributes for a work product, but in a special kind of form.")
};



public ModelMappingFailures openpmSRCFailures = {
	tooDetailed("Comment", "Comments on tasks are very low level and perhaps even an implementation detail.")
	, tooDetailed("Link", "Links on products are very low level and perhaps even an implementation detail.")
	, implementation("Access","Access is a implementation detail of the kind of security role a user has in a system")
	, *implementation({"EmailSubscription", "EmailSubscriptionType"},"Sending emails to users is implementation details of a electronic systeSending emails to users is implementation details of a electronic systemm")
	, *implementation({"Event", "Update", "Create", "Remove", "Add", "Delete", "ObjectVersion", "FieldVersion", "ObjectType","FieldType"},"Part of the Temporal Object/Property pattern, is not related to the domain.")
	, *implementation({"Splitter", "Tab", "TaskButton", "Label"}, "These are UI concepts, the progress of the user through the UI has been made part of the model, but is not related to the domain.")
	, missing("TaskState", "Activities in the reference model do not contain any state tracking.")
	, missing("TaskType", "Activities in the reference model are not subtyped.")
};