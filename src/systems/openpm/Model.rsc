module systems::openpm::Model

import Model::MetaDomain;

public DomainModel openpm = {
	class("Access", 
		[
			attr("name", |project://OpenPM/src/main/java/org/tracka/Access.java|(161,4,<7,0>,<7,0>))
			, attr("id", |project://OpenPM/src/main/java/org/tracka/Access.java|(140,2,<6,0>,<6,0>))
		],
		|project://OpenPM/src/main/java/org/tracka/Access.java|(23,22,<3,0>,<3,0>)
		)
	, class("Attachment",
		[
			attr("clientFileName", |project://OpenPM/src/main/java/org/tracka/Attachment.java|(1472,30,<39,1>,<39,30>))
			, attr("id", |project://OpenPM/src/main/java/org/tracka/Attachment.java|(1308,83,<32,1>,<35,16>))
			, attr("number", |project://OpenPM/src/main/java/org/tracka/Attachment.java|(1445,24,<38,1>,<38,24>))
		],
		[
		],
		|project://OpenPM/src/main/java/org/tracka/Attachment.java|(431,5308,<17,0>,<172,0>)
		)
	, class("Comment",
		[
			attr("creationDate", |project://OpenPM/src/main/java/org/tracka/Comment.java|(1175,26,<31,1>,<31,26>))
			, attr("id", |project://OpenPM/src/main/java/org/tracka/Comment.java|(1089,83,<27,1>,<30,16>))
			, attr("text", |project://OpenPM/src/main/java/org/tracka/Comment.java|(1539,59,<41,1>,<42,20>))
		],
		[
			asso("made by", "User", |project://OpenPM/src/main/java/org/tracka/Comment.java|(1231,63,<33,1>,<35,18>))
			, asso("next", "Comment",|project://OpenPM/src/main/java/org/tracka/Comment.java|(1204,24,<32,1>,<32,24>))
		],
		|project://OpenPM/src/main/java/org/tracka/Comment.java|(201,4888,<11,0>,<172,0>)
		)
	, class("Effort",
		[
			attr("id", |project://OpenPM/src/main/java/org/tracka/Effort.java|(652,65,<24,1>,<26,16>))
			, attr("title", |project://OpenPM/src/main/java/org/tracka/Effort.java|(741,21,<28,1>,<28,21>))
			, attr("value", |project://OpenPM/src/main/java/org/tracka/Effort.java|(720,18,<27,1>,<27,18>))
		],
		[
			
		],
		|project://OpenPM/src/main/java/org/tracka/Effort.java|(296,2246,<13,0>,<108,0>)
		)
	, class("EmailSubscription",
		[
			attr("id", |project://OpenPM/src/main/java/org/tracka/EmailSubscription.java|(396,38,<16,1>,<18,16>))
		],
		[
			asso("target", "User", |project://OpenPM/src/main/java/org/tracka/EmailSubscription.java|(458,61,<20,1>,<22,18>))
			, asso("kind", "EmailSubscriptionType", |project://OpenPM/src/main/java/org/tracka/EmailSubscription.java|(436,20,<19,1>,<19,20>))
		],
		|project://OpenPM/src/main/java/org/tracka/EmailSubscription.java|(141,2079,<9,0>,<105,0>)
		)
	, class("EmailSubscriptionType",
		[
			attr("code", |project://OpenPM/src/main/java/org/tracka/EmailSubscription.java|(1768,20,<80,2>,<80,21>))
			, attr("description", |project://OpenPM/src/main/java/org/tracka/EmailSubscription.java|(1791,27,<81,2>,<81,28>))
		],
		[
			
		],
		|project://OpenPM/src/main/java/org/tracka/EmailSubscription.java|(1581,637,<75,1>,<104,1>)
		)
	/*, class("FieldVersion",
		[
			attr("id", |project://OpenPM/src/main/java/org/tracka/FieldVersion.java|(1489,83,<40,1>,<43,16>))
			, attr("oldValue", |project://OpenPM/src/main/java/org/tracka/FieldVersion.java|(1693,103,<50,1>,<54,24>))
		],
		[
			asso("fieldType", "FieldType", |project://OpenPM/src/main/java/org/tracka/FieldVersion.java|(1631,59,<48,1>,<49,28>))
		],
		|project://OpenPM/src/main/java/org/tracka/FieldVersion.java|(173,3795,<10,0>,<130,0>)
		)
	, class("FieldType",
		[
			attr("description", |project://OpenPM/src/main/java/org/tracka/FieldVersion.java|(1300,27,<29,2>,<29,28>))
		],
		[
			
		],
		|project://OpenPM/src/main/java/org/tracka/FieldVersion.java|(985,499,<26,1>,<38,1>)
		)
	, class("Label",
		[
			attr("bgColor", |project://OpenPM/src/main/java/org/tracka/Label.java|(2165,23,<52,1>,<52,23>))
			, attr("id", |project://OpenPM/src/main/java/org/tracka/Label.java|(1900,83,<38,1>,<41,16>))
			, attr("number", |project://OpenPM/src/main/java/org/tracka/Label.java|(1986,76,<42,1>,<45,37>))
			, attr("textColor", |project://OpenPM/src/main/java/org/tracka/Label.java|(2191,25,<53,1>,<53,25>))
			, attr("title", |project://OpenPM/src/main/java/org/tracka/Label.java|(2139,21,<50,1>,<50,21>))
		],
		[
		],
		|project://OpenPM/src/main/java/org/tracka/Label.java|(441,8140,<17,0>,<294,0>)
		)
	, class("ObjectVersion",
		[
			attr("children", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(3238,126,<87,1>,<88,67>))
			, attr("creationDate", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(3441,78,<93,1>,<94,26>))
			, attr("id", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(3069,83,<78,1>,<81,16>))
			, attr("objectId", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(3524,70,<96,1>,<97,22>))
		],
		[
			asso("children", "ObjectVersion", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(3238,126,<87,1>,<88,67>))
			, asso("creator", "User", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(3369,69,<90,1>,<92,21>))
			, asso("eventType", "Event", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(4160,59,<118,1>,<119,28>))
			, asso("fields", "FieldVersion", {|project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(4224,129,<121,1>,<122,63>),|project://OpenPM/src/main/java/org/tracka/FieldVersion.java|(1577,49,<45,1>,<46,36>)})
			, asso("objectType", "ObjectType", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(4093,62,<115,1>,<116,30>))
			, asso("parent", "ObjectVersion", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(3157,76,<83,1>,<85,29>))
			, asso("taskCurrentTarget", "Product", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(3599,260,<99,1>,<106,25>))
			, asso("taskChangeTarget", "Product", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(3864,224,<108,1>,<113,25>))
		],
		|project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(318,9695,<15,0>,<325,0>)
		)
	, class("Event",
		[
			attr("description", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(2882,27,<68,2>,<68,28>))
		],
		[
			
		],
		|project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(2760,304,<66,1>,<76,1>)
		)
	, specialisation("Create", "Event", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(2788,0,<67,0>,<67,0>))
	, specialisation("Update", "Event", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(2788,0,<67,0>,<67,0>))
	, specialisation("Delete", "Event", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(2788,0,<67,0>,<67,0>))
	, specialisation("Add", "Event", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(2788,0,<67,0>,<67,0>))
	, specialisation("Remove", "Event", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(2788,0,<67,0>,<67,0>))
	, class("ObjectType",
		[
			attr("description", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(2368,27,<49,2>,<49,28>))
		],
		[
			asso("fieldTypes", "FieldType", |project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(2399,44,<50,2>,<50,45>))
		],
		|project://OpenPM/src/main/java/org/tracka/ObjectVersion.java|(1594,1161,<33,1>,<64,1>)
		)
	*/
	, class("Product",
		[
			attr("anonymousCanSubmit", |project://OpenPM/src/main/java/org/tracka/Product.java|(4415,97,<70,1>,<73,43>))
			, attr("id", |project://OpenPM/src/main/java/org/tracka/Product.java|(3866,83,<55,1>,<58,16>))
			, attr("isDeleted", |project://OpenPM/src/main/java/org/tracka/Product.java|(5402,26,<105,1>,<105,26>))
			, attr("iterationEnd", |project://OpenPM/src/main/java/org/tracka/Product.java|(4247,89,<65,1>,<66,39>))
			, attr("iterationLengthInWeeks", |project://OpenPM/src/main/java/org/tracka/Product.java|(4130,114,<63,1>,<64,62>))
			, attr("name", |project://OpenPM/src/main/java/org/tracka/Product.java|(3952,56,<59,1>,<60,20>))
			, attr("velocityPeriodInWeeks", |project://OpenPM/src/main/java/org/tracka/Product.java|(4011,116,<61,1>,<62,65>))
			, attr("velocity", |project://OpenPM/src/main/java/org/tracka/Product.java|(14998,0,<464,0>,<464,0>))
		],
		[
			asso("stateAnonymous", "TaskState", |project://OpenPM/src/main/java/org/tracka/Product.java|(4515,148,<74,1>,<79,33>))
			, asso("stateDone", "TaskState", |project://OpenPM/src/main/java/org/tracka/Product.java|(4339,73,<67,1>,<69,28>))
			, asso("typeAnonymous", "TaskType", |project://OpenPM/src/main/java/org/tracka/Product.java|(4666,145,<80,1>,<85,31>))
			//, asso("has", "Label", |project://OpenPM/src/main/java/org/tracka/Label.java|(2065,69,<46,1>,<48,24>))
			, asso("has", "Link", |project://OpenPM/src/main/java/org/tracka/Product.java|(5007,30,<91,1>,<91,30>))
			, asso("produced by", "Sprint", |project://OpenPM/src/main/java/org/tracka/Sprint.java|(2559,69,<52,1>,<54,24>))
			, asso("decomposed in", "Task", |project://OpenPM/src/main/java/org/tracka/Task.java|(8592,69,<125,1>,<127,24>))
		],
		|project://OpenPM/src/main/java/org/tracka/Product.java|(256,17698,<12,0>,<543,0>)
		)
	, class("Link", [attr("text"), attr("url")], |project://OpenPM/src/main/java/org/tracka/Product.java|(5007,30,<91,1>,<91,30>))
	/*
	, class("Splitter",
		[
			attr("hideOlderThan", |project://OpenPM/src/main/java/org/tracka/Splitter.java|(1387,27,<36,1>,<36,27>))
			, attr("id", |project://OpenPM/src/main/java/org/tracka/Splitter.java|(1072,83,<24,1>,<27,16>))
			, attr("isExpanded", |project://OpenPM/src/main/java/org/tracka/Splitter.java|(1312,34,<34,1>,<34,34>))
			, attr("isFilterOn", |project://OpenPM/src/main/java/org/tracka/Splitter.java|(1349,35,<35,1>,<35,35>))
			, attr("isVertical", |project://OpenPM/src/main/java/org/tracka/Splitter.java|(1436,35,<37,1>,<37,35>))
			, attr("showAssignedToMe", |project://OpenPM/src/main/java/org/tracka/Splitter.java|(1474,33,<38,1>,<38,33>))
			, attr("showTouchedByMe", |project://OpenPM/src/main/java/org/tracka/Splitter.java|(1510,32,<39,1>,<39,32>))
		],
		[
			asso("filters on", "TaskState", |project://OpenPM/src/main/java/org/tracka/Splitter.java|(1221,88,<31,1>,<33,24>))
			, asso("tab", "Tab", |project://OpenPM/src/main/java/org/tracka/Splitter.java|(1158,60,<28,1>,<30,16>))
			, asso("filters on", "TaskType",|project://OpenPM/src/main/java/org/tracka/TaskType2Splitter.java|(448,42,<18,0>,<18,0>))
		],
		|project://OpenPM/src/main/java/org/tracka/Splitter.java|(144,8666,<9,0>,<299,0>)
		)
	*/
	, class("Sprint",
		[
			attr("endTime", |project://OpenPM/src/main/java/org/tracka/Sprint.java|(2631,25,<55,1>,<55,25>))
			, attr("id", |project://OpenPM/src/main/java/org/tracka/Sprint.java|(2265,83,<43,1>,<46,16>))
			, attr("title", |project://OpenPM/src/main/java/org/tracka/Sprint.java|(2678,21,<56,1>,<56,21>))
		],
		[
			asso("next", "Sprint", |project://OpenPM/src/main/java/org/tracka/Sprint.java|(2351,205,<47,1>,<51,37>))
			, asso("contains", "Task", |project://OpenPM/src/main/java/org/tracka/Task.java|(513,0,<18,0>,<18,0>))
		],
		|project://OpenPM/src/main/java/org/tracka/Sprint.java|(233,9453,<12,0>,<282,0>)
		)
	, specialisation("Milestone", "Sprint", |project://OpenPM/src/main/java/org/tracka/Sprint.java|(558,69,<17,0>,<17,0>))
	/*
	, class("Tab",
		[
			attr("id", |project://OpenPM/src/main/java/org/tracka/Tab.java|(1069,83,<29,1>,<32,16>))
			, attr("name", |project://OpenPM/src/main/java/org/tracka/Tab.java|(1373,20,<41,1>,<41,20>))
			, attr("number", |project://OpenPM/src/main/java/org/tracka/Tab.java|(1155,24,<33,1>,<33,24>))
		],
		[
			asso("user", "User", |project://OpenPM/src/main/java/org/tracka/Tab.java|(1182,63,<34,1>,<36,18>))
		],
		|project://OpenPM/src/main/java/org/tracka/Tab.java|(413,5796,<16,0>,<227,0>)
		)
	*/
	, class("Task",
		[
			attr("description", |project://OpenPM/src/main/java/org/tracka/Task.java|(8489,75,<122,1>,<123,32>))
			, attr("doneDate", |project://OpenPM/src/main/java/org/tracka/Task.java|(8353,103,<118,1>,<120,38>))
			, attr("hours", |project://OpenPM/src/main/java/org/tracka/Task.java|(8567,22,<124,1>,<124,22>))
			, attr("id", |project://OpenPM/src/main/java/org/tracka/Task.java|(7884,83,<100,1>,<103,16>))
			, attr("isDeleted", |project://OpenPM/src/main/java/org/tracka/Task.java|(8966,26,<139,1>,<139,26>))
			, attr("modificationDate", |project://OpenPM/src/main/java/org/tracka/Task.java|(8933,30,<138,1>,<138,30>))
			, attr("title", |project://OpenPM/src/main/java/org/tracka/Task.java|(8465,21,<121,1>,<121,21>))
		],
		[
			asso("creator", "User", |project://OpenPM/src/main/java/org/tracka/Task.java|(8664,69,<128,1>,<130,21>))
			, asso("effort", "Effort", |project://OpenPM/src/main/java/org/tracka/Task.java|(8146,87,<111,1>,<113,22>))
			, asso("owner", "User", |project://OpenPM/src/main/java/org/tracka/Task.java|(8736,65,<131,1>,<133,19>))
			, asso("state", "TaskState", |project://OpenPM/src/main/java/org/tracka/Task.java|(8236,88,<114,1>,<116,24>))
			, asso("type", "TaskType", |project://OpenPM/src/main/java/org/tracka/Task.java|(8058,85,<108,1>,<110,22>))
			, asso("has", "Attachment", |project://OpenPM/src/main/java/org/tracka/Attachment.java|(1394,48,<36,1>,<37,20>))
			, asso("has", "Comment", |project://OpenPM/src/main/java/org/tracka/Comment.java|(1488,48,<39,1>,<40,20>))
			//, asso("has", "Label", |project://OpenPM/src/main/java/org/tracka/LabelTask.java|(1387,33,<35,1>,<36,20>))
			, asso("next", "Task", |project://OpenPM/src/main/java/org/tracka/Task.java|(7970,85,<104,1>,<107,37>))
		],
		|project://OpenPM/src/main/java/org/tracka/Task.java|(442,56071,<17,0>,<1425,0>)
		)
	/*
	, class("TaskButton",
		[
			attr("id", |project://OpenPM/src/main/java/org/tracka/TaskButton.java|(2165,83,<42,1>,<45,16>))
			, attr("name", |project://OpenPM/src/main/java/org/tracka/TaskButton.java|(2282,59,<49,1>,<50,20>))
			, attr("number", |project://OpenPM/src/main/java/org/tracka/TaskButton.java|(2253,24,<47,1>,<47,24>))
			, attr("ownerSet", |project://OpenPM/src/main/java/org/tracka/TaskButton.java|(2712,32,<63,1>,<63,32>))
			, attr("ownerUnset", |project://OpenPM/src/main/java/org/tracka/TaskButton.java|(2789,35,<65,1>,<65,35>))
			, attr("ownerUntouched", |project://OpenPM/src/main/java/org/tracka/TaskButton.java|(2747,39,<64,1>,<64,39>))
		],
		[
			asso("from", "TaskState", |project://OpenPM/src/main/java/org/tracka/TaskButton.java|(2498,104,<55,1>,<57,32>))
			, asso("to", "TaskState", |project://OpenPM/src/main/java/org/tracka/TaskButton.java|(2607,100,<59,1>,<61,30>))
			, asso("for", "TaskType", |project://OpenPM/src/main/java/org/tracka/TaskType2TaskButton.java|(1205,19,<25,0>,<25,0>))
		],
		|project://OpenPM/src/main/java/org/tracka/TaskButton.java|(507,10002,<19,0>,<349,0>)
		)
	*/
	, class("TaskState",
		[
			attr("id", |project://OpenPM/src/main/java/org/tracka/TaskState.java|(1945,83,<43,1>,<46,16>))
			, attr("name", |project://OpenPM/src/main/java/org/tracka/TaskState.java|(2182,58,<53,1>,<54,20>))
		],
		[
			asso("next", "TaskState", |project://OpenPM/src/main/java/org/tracka/TaskState.java|(2033,144,<48,1>,<51,24>))
		],
		|project://OpenPM/src/main/java/org/tracka/TaskState.java|(443,12645,<17,0>,<396,0>)
		)
	, class("TaskType",
		[
			attr("id", |project://OpenPM/src/main/java/org/tracka/TaskType.java|(1573,83,<37,1>,<40,16>))
			, attr("image", {|project://OpenPM/src/main/java/org/tracka/TaskType.java|(1723,23,<45,1>,<45,23>), |project://OpenPM/src/main/java/org/tracka/TaskType.java|(1749,23,<46,1>,<46,23>)})
			, attr("name", |project://OpenPM/src/main/java/org/tracka/TaskType.java|(1661,57,<42,1>,<43,20>))
		],
		[
			asso("defaultState", "TaskState", |project://OpenPM/src/main/java/org/tracka/TaskType.java|(1777,103,<48,1>,<50,31>))
			, asso("possible states", "TaskState", |project://OpenPM/src/main/java/org/tracka/TaskType2TaskState.java|(1103,18,<25,0>,<25,0>))
		],
		|project://OpenPM/src/main/java/org/tracka/TaskType.java|(484,5323,<18,0>,<201,0>)
		)
	, class("User",
		[
			attr("email", |project://OpenPM/src/main/java/org/tracka/User.java|(3872,26,<64,1>,<64,26>))
			, attr("firstName", |project://OpenPM/src/main/java/org/tracka/User.java|(3713,64,<59,1>,<60,25>))
			, attr("id", |project://OpenPM/src/main/java/org/tracka/User.java|(3486,83,<50,1>,<53,16>))
			, attr("initials", |project://OpenPM/src/main/java/org/tracka/User.java|(3845,24,<63,1>,<63,24>))
			, attr("isAppAdmin", |project://OpenPM/src/main/java/org/tracka/User.java|(3683,27,<58,1>,<58,27>))
			, attr("isDeleted", |project://OpenPM/src/main/java/org/tracka/User.java|(3572,26,<54,1>,<54,26>))
			, attr("lastName", |project://OpenPM/src/main/java/org/tracka/User.java|(3780,62,<61,1>,<62,24>))
			, attr("login", |project://OpenPM/src/main/java/org/tracka/User.java|(3601,46,<55,1>,<56,21>))
			, attr("passwordDigest", |project://OpenPM/src/main/java/org/tracka/User.java|(3650,30,<57,1>,<57,30>))
			, attr("showHistory", |project://OpenPM/src/main/java/org/tracka/User.java|(4205,35,<73,1>,<73,35>))
		],
		[
			//asso("currentTab", "Tab", |project://OpenPM/src/main/java/org/tracka/User.java|(3979,92,<68,1>,<70,23>))
			asso("participates in", "Product", |project://OpenPM/src/main/java/org/tracka/UserProduct.java|(173,5756,<10,0>,<183,0>))[@class="Access"]
		],
		|project://OpenPM/src/main/java/org/tracka/User.java|(293,14765,<13,0>,<459,0>)
		)
};