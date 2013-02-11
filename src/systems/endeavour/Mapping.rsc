module systems::endeavour::Mapping

import Model::Mapping;

public ModelMappings endeavourMapping = {
	synonym("ProjectMember", "Team Member", reason = "Team is in the context of a project, therefore it is also a project member")
	, equalName("Project", "Project")
	, specialisation("Iteration", "Milestone", reason = "Iterations split the project into chunks of work, Milestones do the same but are not necessarily iterative.")
	, *specialisation({"Task", "WorkProduct"}, "Activity", reason = "Task and WorkProduct are the primary units of work for project members, in the reference model this is the activity entity.")
	, synonym("Dependency", "Activity Dependency")
	, equalName("StartStart", "StartStart")
	, equalName("StartFinish", "StartFinish")
	, equalName("FinishStart", "FinishStart")
	, equalName("FinishFinish", "FinishFinish")
	, equalName("Document", "Documentation", reason = "Same term, but different context", correct = false)
	, equalName("ChangeRequest", "Change request")
	, implementationDetail("Attachement", "Activity Attribute", reason = "Attachements contain extra attributes for a work product, but in a special kind of form.")
	, *specialisation({"UseCase", "Actor"}, "Requirement", reason = "Use cases and actors are a software project specific technique to document requirements, note, actors are not stakeholders, since a stakeholder does not need to interact with the system.")
	, equalName("Defect", "Defect")
};



public ModelMappingFailures endeavourFailures = {
	missing("Version", "Just like Document which is actually missing in the model but overlaps with a wrong term, version is missing")
	, missing("GlossaryTerm", "The glossary terms might be part of project specific documentation such as the scope or the project plan, but missing in the reference model due to level of detail differences")
	, *implementationDetail({"SecurityGroup", "Privilege"}, "Implementation details of the user login.")
	, *domainDetail({"TestPlan", "TestFolder", "TestRun", "Comment", "TestCase", "Event"}, "Testing is something more specific to the software domain, it is not part of the generic project planning domain model, but it is mentioned in the book as an example process, and it is related to the quality plan")
};