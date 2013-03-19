module systems::endeavour::SRCMapping

import Meta::Mapping;

public ModelMappings endeavourSRCMapping = {
	synonym("ProjectMember", {"Team Member", "Stakeholder"}, reason = "Team is in the context of a project, therefore it is also a project member, also it is used as a stakeholder")
	
	, equalName("Project", "Project")
		[@attrs={
			equalName("name", "name")
			, synonym("id", "number")
			, synonym("startDate", "begin")
			, synonym("endDate", "end")
		}]
		[@missingAttr={
			*tooDetailed({"createdBy", "description"}, "This information could be part of the project plan, but is to level for the reference model.")
			, missing("status", "the concept of status is not captured in one attribute in the reference model")
		}]
		
	, specialisation("Iteration", "Milestone", reason = "Iterations split the project into chunks of work, Milestones do the same but are not necessarily iterative.")
		[@attrs={
			synonym("startDate", "begin")
			, synonym("endDate", "end")
		}]
		[@missingAttr={
			implementation("id", "since everything is stored in a database, all entities need an id")
			, missing("name", "The reference book does not discuss the properties of a milestone, although a name could be part of it")
			, tooDetailed("createdBy", "The reference model does not contain a audit log of who created an entity.")
			, differentDesign("progress", "The reference model does not contain a single attribute to store the progress")
		}]
		
	, specialisation({"Task", "WorkProduct"}, "Activity", reason = "Task and WorkProduct are the primary units of work for project members, in the reference model this is the activity entity.")
		[@attrs={
			synonym("description", "scope of work desription")
			, synonym("startDate", "begin")
			, synonym("endDate", "end")
			, synonym("id", "identifier")
			, equalName("name", "name")
		}]
		[@missingAttr={
			tooDetailed("priority", "")
			, tooDetailed("label", "")
			, tooDetailed("createdBy", "")
			, differentDesign("progress", "The reference model does not contain a single attribute to store the progress")
			, missing("status", "the concept of status is not captured in one attribute in the reference model")
		}]
		
	, synonym("Dependency", "Activity Dependency")
		[@missingAttr={
			implementation("id", "since everything is stored in a database, all entities need an id")
		}]
		
	, equalName("StartStart", "StartStart")
	, equalName("StartFinish", "StartFinish")
	, equalName("FinishStart", "FinishStart")
	, equalName("FinishFinish", "FinishFinish")
	
	, equalName("Document", "Documentation", reason = "Same term, but different context", correct = false)
	
	, equalName("ChangeRequest", "Change request")
		[@missingAttr={
			differentDesign("type", "In the reference model, subtyping is used")
		}]
		
	, implementationDetail("Attachment", "Activity Attribute", reason = "Attachments contain extra attributes for a work product, but in a special kind of form.")
	
	, specialisation({"UseCase", "Actor"}, "Requirement", reason = "Use cases and actors are a software project specific technique to document requirements, note, actors are not stakeholders, since a stakeholder does not need to interact with the system.")
	
	, equalName("Defect", "Defect")
};



public ModelMappingFailures endeavourSRCMappingFailures = {
	missing("Version", "Just like Document which is actually missing in the model but overlaps with a wrong term, version is missing")
	, missing("GlossaryTerm", "The glossary terms might be part of project specific documentation such as the scope or the project plan, but missing in the reference model due to level of detail differences")
	, *implementation({"SecurityGroup", "Privilege"}, "Implementation details of the user login.")
	, *domainDetail({"TestPlan", "TestFolder", "TestRun", "Comment", "TestCase", "Event"}, "Testing is something more specific to the software domain, it is not part of the generic project planning domain model, but it is mentioned in the book as an example process, and it is related to the quality plan")
};