module systems::endeavour::USRModel

import Meta::Domain;

public DomainModel endeavourUSR = {
	class("ProjectMember/Stakeholder", [
		asso("assigned", "X", "Home")
		, asso("part of", "Project", "Home")
		, asso("part of", "Security Group", "Security groups")
		], {"Home", "User", "Use Case"})
		
	, class("X" ,[
		asso("has", "ProjectMember/Stakeholder", "Home-Task details")
		, asso("has", "Document", "Home-Task details")
		, asso("has", "Attachment", "Home-Task details")
		, asso("has", "Comment", "Home-Task details")
		, asso("part of", "Iteration", "Home-Task details")
		], {"Home", "Home-Task details", "Home-Use Case details"})
		
	, class("Comment", [ 
		asso("made by", "ProjectMember/Stakeholder", "Home-Use Case details")
		], "Home-Use Case details")
		
	, specialisation("Task", "X",[
		asso("has", "Task Dependency", "Home-Task details")
		], "Home-Task details")
		
	, class("Task Dependency", [
		asso("depends on", "Task", "Home-Task details")
		], "Home-Task details")
	, specialisation("FinishStart", "Task Dependency", "Home-Task details")
	, specialisation("StartStart", "Task Dependency", "Home-Task details")
	, specialisation("FinishFinish", "Task Dependency", "Home-Task details")
	, specialisation("StartFinish", "Task Dependency", "Home-Task details")
		
	, specialisation("Use Case", "X", [
		asso("include", "Use Case", "Home-Use Case details")		
		, asso("exclude", "Use Case", "Home-Use Case details")		
		, asso("has", "Actor", "Home-Use Case details")		
		, asso("contains", "Task", "Home-Use Case details")
		], "Home-Use Case details")
	
	, specialisation("Defect", "X", [
	
		], "Home-Defect details")
	
	, specialisation("Change Request", "X", [
	
		], "Iteration")
		
	, class("Actor", "Home-Use Case details")
	
	, class("Project", [
		asso("has", "ProjectMember/Stakeholder", "Home-Project details")
		, asso("has", "Glossary", "Project Glossary")
		, asso("has", "Iteration", "Iterations")
		, asso("has", "X", "Home-Task details")
		, asso("has", "Actor", "Actors")
		, asso("has", "Test Case", "Test Case")
		], "Home-Project details")
	
	, class("Glossary", "Project Glossary")
		
	, class("Iteration", [
		asso("has", "X", "Iteration-details")	
		], {"Iteration", "Home-Task details"})
		
	
	
	, class("Test Case", [
		asso("created by", "ProjectMember/Stakeholder", "Test cases")
		, asso("has", "ProjectMember/Stakeholder", "Test cases")
		, asso("has", "Event", "Test cases")
		, asso("has", "Comment", "Test cases")
		], "Test cases")
	, class("Event", "Test cases")
	
	, class("Test Plan", [
		asso("contains", "Test Folder", "Test plan")	
		], "Test plan")
	, class("Test Folder", [
		asso("contains", "Test Case", "Test plan")	
		], "Test plan")
	
	, class("Document", [
		asso("contains", "Attachment", "Project document")
		, asso("previous", "Document", "Project document")
		], "Project document")
	
	, class("Security Group", "Security Groups")
	
	, class("Attachment", {"Project Documentation", "Home-Task details" }) 
};