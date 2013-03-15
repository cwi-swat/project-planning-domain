module systems::endeavour::INTModelMapping

import Meta::Mapping;

public ModelMappings endeavourINTMapping = {
	equalName("ProjectMember", "ProjectMember/Stakeholder")
	, equalName("Project", "Project")
	, equalName("Iteration", "Iteration")
	, equalName("Task", "Task")
	, synonym("WorkProduct", "X", reason = "The speciality is not exactly clear in the UI, but in source it is.")
	, equalName("Dependency", "Task Dependency")
	, equalName("StartStart", "StartStart")
	, equalName("StartFinish", "StartFinish")
	, equalName("FinishStart", "FinishStart")
	, equalName("FinishFinish", "FinishFinish")
	, equalName("Document", "Document")
	, equalName("ChangeRequest", "Change Request")
	, equalName("Attachment", "Attachment")
	, equalName("Actor", "Actor")
	, equalName("UseCase", "Use Case")
	, equalName("Defect", "Defect")
	, equalName("Comment", "Comment")
	, equalName("GlossaryTerm", "Glossary")
	, equalName("SecurityGroup", "Security Group")
	, equalName("TestPlan", "Test Plan")
	, synonym({"TestFolder", "TestRun"}, "Test Folder",  reason="In implementation this is split, while UI this split is not that clear.")
	, equalName("TestCase", "Test Case")
	, equalName("Event", "Event")
};



public ModelMappingFailures endeavourINTFailures = {
	implementation("Version", "Implementation details how versions are kept for the document.")
	, implementation("Privilege", "Implementation details of the user login.")
};