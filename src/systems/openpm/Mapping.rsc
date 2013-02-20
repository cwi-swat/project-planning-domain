module systems::openpm::Mapping

import Model::Mapping;

public ModelMappings openpmMapping = {
	synonym("User", "Team Member", reason = "Since users are connected to tasks, they are the team members.")
	, extension("Product", "Deliverable", reason="The closest match is the deliverable, but it the Product is actually more than just the deliverable")
	, synonym("Task", "Activity")
	, synonym("Sprint", "Project schedule", reason = "The order of the task are stored in a sprint, and in the task.")
	, equalName("Milestone", "Milestone")
	, synonym("Effort", "Activity duration", reason = "The effort of a task is the time it costs to complete it.")
	, implementationDetail("Attachment", "Activity Attribute", reason = "Attachments contain extra attributes for a work product, but in a special kind of form.")
};



public ModelMappingFailures openpmFailures = {
	tooDetailed("Comment", "Comments on tasks are very low level and perhaps even an implementation detail.")
	, tooDetailed("Link", "Links on products are very low level and perhaps even an implementation detail.")
	, *implementation({"EmailSubscription", "EmailSubscriptionType"},"Sending emails to users is implementation details of a electronic systeSending emails to users is implementation details of a electronic systemm")
	, missing("TaskState", "Activities in the reference model do not contain any state tracking.")
	, missing("TaskType", "Activities in the reference model are not subtyped.")
};