module systems::endeavour::USRMapping

import Meta::Mapping;

public ModelMappings endeavourUSRMapping = {
	synonym("ProjectMember/Stakeholder", {"Team Member", "Stakeholder"}, reason = "Team is in the context of a project, therefore it is also a project member, but it is also used as stakeholder")
	
	, equalName("Project", "Project")
		
	, specialisation("Iteration", "Milestone", reason = "Iterations split the project into chunks of work, Milestones do the same but are not necessarily iterative.")
		
	, specialisation({"Task", "X"}, "Activity", reason = "Looking at the source code, X is actually WorkProduct. Task and WorkProduct are the primary units of work for project members, in the reference model this is the activity entity.")
		
	, synonym("Task Dependency", "Activity Dependency")
		
	, equalName("StartStart", "StartStart")
	, equalName("StartFinish", "StartFinish")
	, equalName("FinishStart", "FinishStart")
	, equalName("FinishFinish", "FinishFinish")
	
	, equalName("Document", "Documentation", reason = "Same term, but different context", correct = false)
	
	, equalName("Change Request", "Change request")
		
	, implementationDetail("Attachment", "Activity Attribute", reason = "Attachments contain extra attributes for a work product, but in a special kind of form.")
	
	, specialisation({"Use Case", "Actor"}, "Requirement", reason = "Use cases and actors are a software project specific technique to document requirements, note, actors are not stakeholders, since a stakeholder does not need to interact with the system.")
	
	, equalName("Defect", "Defect")
};



public ModelMappingFailures endeavourUSRMappingFailures = {
	missing("Glossary", "The glossary might be part of project specific documentation such as the scope or the project plan, but missing in the reference model due to level of detail differences")
	, implementation("Security Group", "Implementation details of the user login.")
	, *domainDetail({"Test Plan", "Test Folder", "Event", "Comment", "Test Case"}, "Testing is something more specific to the software domain, it is not part of the generic project planning domain model, but it is mentioned in the book as an example process, and it is related to the quality plan")
};