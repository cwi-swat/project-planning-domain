module Domain::Project

import Model::MetaDomain;


public DomainModel project = {
	class("Portofolio", [], [asso("contains", "Project", {16})], {16}),
	class("Environment", [], [asso("influences", "Project")], {20})[@alternativeNames={"Enterprise environment"}],
	specialisation("Internal", "Environment", {20}),
	specialisation("External", "Environment", {20}),
	class("Project", 
		[
			attr("name", {22}),
			attr("number", {22}),
			attr("begin", {2,25}),
			attr("end", {2})	
		],
		[
			asso("creates", "Result", {1,19}),
			asso("has", "Objective", \one(), oneOrMore(), {3}),
			asso("has", "Requirement", \one(), oneOrMore(), {5}),
			asso("has", "StakeHolder", \one(), oneOrMore(), {7}),
			asso("balances", "Constrain", \one(), oneOrMore(), {8}),
			asso("follows", "Life cycle", {24}),
			asso("follows", "Project plan", {55}),
			asso("subdivised in", "Work Breakdown Structure", {58})
			,asso("has", "Milestone", {108})
		],
		{1}),
	class("Result", {1}),
	specialisation("Product", "Result", {19}),
	specialisation("Service", "Result", {19}),
	class("Objective", {3}),
	class("Requirement", 
		[
			attr("version", {12})
		],
		[
			asso("previous", "Requirement", noneOrMore(), noneOrMore(), {12})
		],
		{5}),
	class("StakeHolder",
		[
			attr("identity", {40}),
			attr("needs", {7}),
			attr("concerns", {7}),
			attr("expectations", {7})
		], 
		[
			asso("priority", "Constrain", oneOrMore(), oneOrMore(), {11}),
			asso("objective", "Requirement", {56})
			,asso("needs", "Information", {68})[@class="Communications plan"]
		],
		{7}),
	class("Information", {68}),
	specialisation("Person", "StakeHolder", {38}),
	specialisation("Organisation", "StakeHolder", {38}),
	
	class("Milestone", 
		[
			attr("mandatory", {109})
			,attr("lag time", {111})
			,attr("lead time", {111})
		],
		[
			asso("previous", "Milestone", {110})
			,asso("following", "Milestone", {110})	
		], {108,109}),
	
	class("Constrain",
		[
		],
		[
			asso("competes with", "Constrain", {8,10}),
			asso("related to", "Constrain", {10})
		],
		{8}),
		
	specialisation("Scope", "Constrain", [], 
		[
			asso("describes", "Project", {57}),
			asso("describes", "Product", {57})
		], {9}),
			
	specialisation("Quality", "Constrain", {9}),
	specialisation("Schedule", "Constrain", 
		[
		],
		[
			asso("constists of", "Project schedule", {97})
			,asso("constists of", "Schedule baseline", {97})
			,asso("constists of", "Schedule data", {97})
		], {9}),
	specialisation("Budget", "Constrain", {9}),
	specialisation("Resource", "Constrain", {9}),
	specialisation("Risk", "Constrain", 
		[
			attr("characteristics", {70})
			,attr("probability", {70})
			,attr("impact", {70})
		],
		[
			asso("affects", "Project", {70})	
			,asso("affects", "Objective", {70})
		], {9})[@alternativeNames = {"Project risk"}],
	
	specialisation("Material", "Resource", {61}),
	specialisation("People", "Resource", {61}),
	specialisation("Equipment", "Resource", {61}),
	specialisation("Supplies", "Resource", {61}),
	
	
	class("Schedule baseline", [], [asso("based on", "Project schedule", {135})],{97}),
	class("Schedule data", [], 
		[
			asso("requires", "Activity resource", {137})
			,asso("alternatives", "Project schedule", {137})
		], {97}),
	

	class("Project plan",
		[
			attr("version", {14, 55})
		],
		[
			asso("previous", "Project plan", noneOrMore(), noneOrMore(), {14, 55})
		]
		)
		[@alternativeNames = {"Project management plan"}],
		
	class("Life cycle", 
		[
		
		],
		[
			asso("composed of", "Phase", \one(), \oneOrMore(), {21})
		],
		{21, 24}),
	
	class("Phase", 
		[
			attr("focus", {32})
		], 
		[
			asso("completes", "Deliverable", {30, 31}),
			asso("previous", "Phase", {35, 36, 37}),
			asso("following", "Phase", {35,36, 37})
		], {21}),
		
	specialisation("Organizing", "Phase", {26}),
	specialisation("Preparing", "Phase", {26}),
	specialisation("Main", "Phase", {27}),
	specialisation("Closing", "Phase", {28}),
	
	class("Deliverable", {30}),
	
	class("Process",
		[
			attr("input", {44}),
			attr("tools", {44}),
			attr("technique", {44})
		],
		[
			asso("related to", "Process", {43}),
			asso("accieves", "Result", {43})
		], {43}),
		
	specialisation("Activity", "Process", 
		[
			attr("identifier", {102})
			,attr("scope of work description", {102})
			,attr("name", {104})
			,attr("lag time", {111})
			,attr("lead time", {111})
		] ,
		[
			asso("produce", "Deliverable", {59}),
			asso("requires", "Resource", {61})[@class="Activity resource"],
			asso("takes", "Activity duration", {62, 95})
			//,asso("based on", "Template", {90})
			,asso("constists of", "Work Breakdown Structure", {94})
			,asso("described by", "Activity Attribute", {103})
			,asso("assigned to", "Team Member", {106})
			,asso("previous", "Milestone", {110})
			,asso("next", "Milestone", {110})
			,asso("depends on", "Activity relation", {113})
		], {43})[@alternativeNames={"Schedule activity"}],
	specialisation("Action", "Process", {43}),
	
	class("Activity relation", [attr("mandatory", {112})], {113}),
	
	class("Activity sequence", [], [asso("sequence", "Activity", {60})], {60}),
	class("Activity resource", [attr("is estimation", {61}), attr("quantity", {123})], {61, 94}),
	class("Activity duration", [attr("is estimation", {62}), attr("duration", {62})], {62, 95}),
	// how about activity durations and resources? these are collections of all the durations per activity
	
	class("Activity template", {90}),
	class("Activity list", [],
		[
			asso("lists", "Activity", {101})	
		],{101}),
	
	class("Activity Attribute", [attr("name", {103}), attr("value", {103})], {103}),
	
	class("Team Member", {106}),
	// what is difference between this and project plan?
	class("Project schedule",
		[
		],
		[
			// not sure if these are assocations
			asso("based on", "Activity sequence", {63}),
			asso("based on", "Activity duration", {63}),
			asso("based on", "Activity resource", {63}),
			asso("based on", "Schedule", {63})
			,asso("schedules", "Milestone", {130})[@class="Schedule Dates"]
			,asso("schedules", "Activity", {130})[@class="Schedule Dates"]
			,asso("previous version", "Project schedule", {135})
			,asso("includes", "Documentation", {136})
		], {63})
	
	,class("Documentation", {136})
	
	,class("Schedule Dates", [attr("begin"), attr("end")], {130})
		
	,class("Project schedule network diagram",
		[
		],
		[
			asso("contains", "Activity sequence", {93})
			,asso("dependens on", "Activity relation", {116})
		], {93})
	// relation between these plans an the project plan?
	,class("Human Resource Plan",
		[
			attr("project roles")
			,attr("responsibilities")
			,attr("required skills")
			,attr("reporting relationships")
			,attr("staffing management plan")
			,attr("authority", {145})
			,attr("training needs", {145})
		],
		[
			asso("plans", "Resource calendar", {145})
		], {67, 142})
		
	,class("Communications plan", [ attr("strategy")], {68})
	,class("Risk management plan", [], [asso("manages", "Risk",{69})], {69})

	,class("Approver")
	,specialisation("Project management", "Approver", {80})
	,specialisation("Change Control Board", "Approver", {80})
	,class("Change request",
		[
			attr("state")	
		],
		[
			asso("approved by", "Approver", {80})
			,asso("rejected by" , "Approver", {80})	
			,asso("influences", "Activity sequence", {81})
			,asso("influences", "Schedule", {81})
			,asso("influences", "Risk management plan", {81})
		], {80})
	
	,class("Work Breakdown Structure",
		[
		
		],
		[
			asso("decomposed in", "Work Breakdown Structure Component", {82})	
		], {58, 82})[@alternativeNames = {"WBS"}]
		
	,class("Work Breakdown Structure Component",
		[
		
		],
		[
			asso("accomplishes", "Objective", {82})
			,asso("creates",  "Deliverable", {82})
			,asso("consists out of", "Work Breakdown Structure Component", {82})	
		], {82})
	,specialisation("Work Package", "Work Breakdown Structure Component", 
		[
		
		],
		[
			asso("plans", "Planned work", {83})
			,asso("constists of", "Activity", {99})
		], {83})
	,class("Planned work", {83})
	
	,class("Resource calendar",
		[],
		[
			asso("available", "Resource", {118, 119})[@class="Resource calendar availability"]
		], {118})
	,class("Resource calendar availability", 
		[
			attr("when")
			,attr("how long")
			,attr("type", {126})
			,attr("capabilities", {126})
		], {119})
		
		// these composite resource calendars are not mentioned for the rest of the book?
	,class("Composite resource calendar", [],
		[
			asso("available", "People", {120})[@class="Composite resouce calendar availability"]
		], {120})
	,class("Composite resouce calendar availability",
		[
			attr("capabilities")
			,attr("skills")
		], {120})
};

public set[str] ProjectOnly =
	 {
	 	"Organisation","Project","Person","Environment","Risk","Equipment","Supplies",
	 	"Communications plan","External","Budget","Preparing","Life cycle","Portofolio",
	 	"Deliverable","Quality","Internal","Phase","Main","Constrain","Action",
	 	"Milestone","Product","Process","Project management","Material","Organizing",
	 	"Result","Scope","People","Activity","Resource","StakeHolder","Requirement",
	 	"Documentation","Objective","Closing","Service","Information", "Change request", 
	 	"Change Control Board", "Approver", "Risk", "Risk management plan", "Project plan"
	 };
