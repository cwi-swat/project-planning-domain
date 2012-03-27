module Domain::Project

import Model::MetaDomain;


public DomainModel project = {
	class("Protofolio", [], [asso("contains", "Project", {16})], {16}),
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
		],
		{7}),
	specialisation("Person", "StakeHolder", {38}),
	specialisation("Organisation", "StakeHolder", {38}),
	
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
	specialisation("Schedule", "Constrain", {9}),
	specialisation("Budget", "Constrain", {9}),
	specialisation("Resource", "Constrain", {9}),
	specialisation("Risk", "Constrain", {9}),
	
	specialisation("Material", "Resource", {61}),
	specialisation("People", "Resource", {61}),
	specialisation("Equipment", "Resource", {61}),
	specialisation("Supplies", "Resource", {61}),

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
		
	specialisation("Activity", "Process", [] ,
		[
			asso("produce", "Deliverable", {59}),
			asso("requires", "Resource", {61})[@class="Activity resource"],
			asso("takes", "Activity duration", {62})
		], {43}),
	specialisation("Action", "Process", {43}),
	
	class("Activity sequence", [], [asso("sequence", "Activity", {60})], {60}),
	class("Activity resource", [attr("is estimation", {61})], {61}),
	class("Activity duration", [attr("is estimation", {62}), attr("duration", {62})], {62}),
	
	class("Work Breakdown Structure", {58})[@alternativeNames={"WBS"}],
	
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
		], {63})
};