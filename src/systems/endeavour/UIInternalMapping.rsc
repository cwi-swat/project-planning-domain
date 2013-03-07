module systems::endeavour::UIInternalMapping

import Model::Mapping;

public ModelMappings endeavourUIInternalMapping = {
	equalName("ProjectMember/Stakeholder", "Project Member")
	, equalName("Project", "Project")
	, equalName("Iteration", "Iteration")
	, equalName("Task", "Task")
	, synonym("X", "WorkProduct", reason = "The speciality is not exactly clear in the UI, but in source it is.")
	, equalName("Task Dependency", "Dependency")
	, equalName("StartStart", "StartStart")
	, equalName("StartFinish", "StartFinish")
	, equalName("FinishStart", "FinishStart")
	, equalName("FinishFinish", "FinishFinish")
	, equalName("Document", "Document")
	, equalName("Change Request", "ChangeRequest")
	, equalName("Attachment", "Attachment")
	, equalName("Actor", "Actor")
	, equalName("Use Case", "UseCase")
	, equalName("Defect", "Defect")
	, equalName("Comment", "Comment")
	, equalName("Glossary", "GlossaryTerm")
	, equalName("Security Group", "SecurityGroup")
	, equalName("Test Plan", "TestPlan")
	, synonym("Test Folder", {"TestFolder", "TestRun"}, reason="In implementation this is split, while UI this split is not that clear.")
	, equalName("Test Case", "TestCase")
	, equalName("Event", "Event")
};



public ModelMappingFailures endeavourUIInternalFailures = {
	implementation("Version", "Implementation details how versions are kept for the document.")
	, implementation("Privelege", "Implementation details of the user login.")
};