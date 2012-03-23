module Domain::Project

import Model::MetaDomain;


public DomainModel project = {
	class("Project", 
		[
			attr("begin", {2}),
			attr("end", {2})	
		],
		[
			asso("creates", "Result", {1}),
			asso("has", "Objective", \one(), oneOrMore(), {3}),
			asso("has", "Requirement", \one(), oneOrMore(), {5}),
			asso("has", "StakeHolder", \one(), oneOrMore(), {7}),
			asso("balances", "Constrain", \one(), oneOrMore(), {8}) 
		],
		{1}),
	class("Result", {1}),
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
			attr("needs", {7}),
			attr("concerns", {7}),
			attr("expectations", {7})
		], 
		[
			asso("priority", "Constrain", oneOrMore(), oneOrMore(), {11})
		],
		{7}),
	class("Constrain",
		[
		],
		[
			asso("competes with", "Constrain", {8,10}),
			asso("related to", "Constrain", {10})
		],
		{8}),
	specialisation("Scope", "Constrain", {9}),
	specialisation("Quality", "Constrain", {9}),
	specialisation("Schedule", "Constrain", {9}),
	specialisation("Budget", "Constrain", {9}),
	specialisation("Resource", "Constrain", {9}),
	specialisation("Risk", "Constrain", {9})

};