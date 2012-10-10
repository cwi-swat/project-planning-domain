module X
import Model::MetaDomain;
DomainModel endeavour = {
	class("Actor",
		[
			attr("description", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Actor.java|(1316,34,<34,1>,<34,34>))
			, attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Actor.java|(1257,26,<32,1>,<32,26>))
			, attr("name", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Actor.java|(1286,27,<33,1>,<33,27>))
			, attr("useCases", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Actor.java|(1353,37,<35,1>,<35,37>))
		],
		[
			asso("belongs to", "Project", {|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Actor.java|(1393,31,<36,1>,<36,31>), |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Actor.java|(1857,0,<61,0>,<61,0>)})
			, asso("assigned to", "UseCase", {|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Actor.java|(1353,37,<35,1>,<35,37>),|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Actor.java|(4630,0,<167,0>,<167,0>)})
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Actor.java|(1203,4013,<30,0>,<190,0>)
		)
	, class("Attachment",
		[
			attr("file", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Attachment.java|(1322,27,<34,1>,<34,27>))
			, attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Attachment.java|(1263,26,<32,1>,<32,26>))
			, attr("name", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Attachment.java|(1292,27,<33,1>,<33,27>))
		],
		[
			asso("workProduct", "WorkProduct", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Attachment.java|(1352,39,<35,1>,<35,39>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Attachment.java|(1199,3082,<30,0>,<147,0>)
		)
	, specialisation("ChangeRequest", "WorkProduct",
		[
			attr("type", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/ChangeRequest.java|(1150,27,<28,1>,<28,27>))
		],
		[
			
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/ChangeRequest.java|(1097,1612,<26,0>,<97,0>)
		)
	, class("Comment",
		[
			attr("author", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Comment.java|(1403,29,<38,1>,<38,29>))
			, attr("date", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Comment.java|(1435,25,<39,1>,<39,25>))
			, attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Comment.java|(1344,26,<36,1>,<36,26>))
			, attr("text", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Comment.java|(1373,27,<37,1>,<37,27>))
		],
		[
			asso("for", "TestCase", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Comment.java|(1505,33,<41,1>,<41,33>))
			, asso("during", "TestRun", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Comment.java|(1541,31,<42,1>,<42,31>))
			, asso("on", "WorkProduct", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Comment.java|(1463,39,<40,1>,<40,39>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Comment.java|(1179,2911,<30,0>,<159,0>)
		)
	, specialisation("Defect", "WorkProduct",
		[
			
		],
		[
			
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Defect.java|(1097,1147,<26,0>,<75,0>)
		)
	, class("Dependency",
		[
			attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Dependency.java|(1183,26,<30,1>,<30,26>))
			, attr("type", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Dependency.java|(1212,27,<31,1>,<31,27>))
		],
		[
			asso("predecessor", "Task", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Dependency.java|(1274,32,<33,1>,<33,32>))
			, asso("sucessor", "Task", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Dependency.java|(1242,29,<32,1>,<32,29>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Dependency.java|(1153,2379,<28,0>,<125,0>)
		)
	, class("Document",
		[
			attr("description", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Document.java|(1292,34,<33,1>,<33,34>))
			, attr("fileName", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Document.java|(1329,31,<34,1>,<34,31>))
			, attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Document.java|(1263,26,<32,1>,<32,26>))
		],
		[
			asso("part of", "Project", {|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Document.java|(1363,31,<35,1>,<35,31>), |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Document.java|(3056,0,<106,0>,<106,0>)})
			, attr("versions", "Version", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Document.java|(1397,38,<36,1>,<36,38>))
			, attr("current", "Version", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Document.java|(6722,0,<230,0>,<230,0>))
			, attr("assigned to", "WorkProduct", {|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Document.java|(1438,45,<37,1>,<37,45>), |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Document.java|(5492,0,<190,0>,<190,0>)})
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Document.java|(1203,6202,<30,0>,<258,0>)
		)
	, class("Event",
		[
			attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Event.java|(1153,26,<30,1>,<30,26>))
			, attr("index", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Event.java|(1182,28,<31,1>,<31,28>))
			, attr("text", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Event.java|(1213,27,<32,1>,<32,27>))
		],
		[
			asso("parent", "Event", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Event.java|(1284,33,<34,1>,<34,33>))
			, asso("testCase", "TestCase", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Event.java|(1362,33,<36,1>,<36,33>))
			, asso("workProduct", "WorkProduct", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Event.java|(1320,39,<35,1>,<35,39>))
			, asso("extensions", "Event", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Event.java|(1243,38,<33,1>,<33,38>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Event.java|(1128,2735,<28,0>,<149,0>)
		)
	, class("GlossaryTerm",
		[
			attr("createdBy", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/GlossaryTerm.java|(1281,32,<33,1>,<33,32>))
			, attr("description", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/GlossaryTerm.java|(1244,34,<32,1>,<32,34>))
			, attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/GlossaryTerm.java|(1185,26,<30,1>,<30,26>))
			, attr("name", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/GlossaryTerm.java|(1214,27,<31,1>,<31,27>))
		],
		[
			asso("for", "Project", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/GlossaryTerm.java|(1316,31,<34,1>,<34,31>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/GlossaryTerm.java|(1153,2867,<28,0>,<144,0>)
		)
	, class("Iteration",
		[
			attr("createdBy", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Iteration.java|(1357,32,<35,1>,<35,32>))
			, attr("startDate", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Iteration.java|(1426,30,<37,1>,<37,30>))
			, attr("endDate", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Iteration.java|(1459,28,<38,1>,<38,28>))
			, attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Iteration.java|(1298,26,<33,1>,<33,26>))
			, attr("name", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Iteration.java|(1327,27,<34,1>,<34,27>))
			, attr("progress", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Iteration.java|(7071,0,<239,0>,<239,0>))
		],
		[
			asso("project", "Project", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Iteration.java|(1392,31,<36,1>,<36,31>))
			, asso("workProducts", "WorkProduct", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Iteration.java|(1490,46,<39,1>,<39,46>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Iteration.java|(1213,6644,<30,0>,<266,0>)
		)
	, class("Privilege",
		[
			attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Privilege.java|(1031,26,<25,1>,<25,26>))
			, attr("value", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Privilege.java|(1060,28,<26,1>,<26,28>))
		],
		[
			asso("securityGroup", "SecurityGroup", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Privilege.java|(1091,43,<27,1>,<27,43>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Privilege.java|(1002,818,<23,0>,<65,0>)
		)
	, class("Project",
		[
			attr("createdBy", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Project.java|(1563,32,<42,1>,<42,32>))
			, attr("description", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Project.java|(1430,34,<38,1>,<38,34>))
			, attr("startDate", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Project.java|(1467,30,<39,1>,<39,30>))
			, attr("endDate", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Project.java|(1500,28,<40,1>,<40,28>))
			, attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Project.java|(1371,26,<36,1>,<36,26>))
			, attr("name", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Project.java|(1400,27,<37,1>,<37,27>))
			, attr("status", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Project.java|(1531,29,<41,1>,<41,29>))
		],
		[
			asso("has", "Actor", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Project.java|(1778,34,<47,1>,<47,34>))
			, asso("has", "Document", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Project.java|(1735,40,<46,1>,<46,40>))
			, asso("defines", "GlossaryTerm", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Project.java|(1815,48,<48,1>,<48,48>))
			, asso("contains", "Iteration", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Project.java|(1598,42,<43,1>,<43,42>))
			, asso("has", "ProjectMember", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Project.java|(1909,49,<50,1>,<50,49>))
			, asso("has", "TestCase", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Project.java|(1692,40,<45,1>,<45,40>))
			, asso("has", "TestPlan", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Project.java|(1866,40,<49,1>,<49,40>))
			, asso("delivers", "WorkProduct", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Project.java|(1643,46,<44,1>,<44,46>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Project.java|(1288,16886,<33,0>,<634,0>)
		)
	, class("ProjectMember",
		[
			attr("acceptNotifications", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/ProjectMember.java|(1620,43,<44,1>,<44,43>))
			, attr("email", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/ProjectMember.java|(1589,28,<43,1>,<43,28>))
			, attr("firstName", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/ProjectMember.java|(1458,32,<39,1>,<39,32>))
			, attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/ProjectMember.java|(1363,26,<36,1>,<36,26>))
			, attr("lastName", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/ProjectMember.java|(1493,31,<40,1>,<40,31>))
			, attr("role", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/ProjectMember.java|(1559,27,<42,1>,<42,27>))
			, attr("status", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/ProjectMember.java|(1527,29,<41,1>,<41,29>))
			, attr("statusDate", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/ProjectMember.java|(1666,31,<45,1>,<45,31>))
		],
		[
			asso("securityGroup", "SecurityGroup", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/ProjectMember.java|(1700,43,<46,1>,<46,43>))
			, asso("projects", "Project", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/ProjectMember.java|(1794,37,<48,1>,<48,37>))
			, asso("testRuns", "TestRun", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/ProjectMember.java|(1834,37,<49,1>,<49,37>))
			, asso("workProducts", "WorkProduct", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/ProjectMember.java|(1746,45,<47,1>,<47,45>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/ProjectMember.java|(1293,12811,<34,0>,<484,0>)
		)
	, class("SecurityGroup",
		[
			attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/SecurityGroup.java|(1302,26,<33,1>,<33,26>))
			, attr("name", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/SecurityGroup.java|(1331,27,<34,1>,<34,27>))
		],
		[
			asso("privileges", "Privilege", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/SecurityGroup.java|(1361,42,<35,1>,<35,42>))
			, asso("projectMembers", "ProjectMember", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/SecurityGroup.java|(1406,50,<36,1>,<36,50>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/SecurityGroup.java|(1237,4407,<30,0>,<189,0>)
		)
	, class("Task",
		[
		],
		[
			asso("workProduct", "WorkProduct", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Task.java|(1372,39,<34,1>,<34,39>))
			, asso("dependencies", "Dependency", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Task.java|(1414,45,<35,1>,<35,45>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Task.java|(1296,8790,<31,0>,<308,0>)
		)
	, class("TestCase",
		[
			attr("createdBy", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestCase.java|(1378,32,<36,1>,<36,32>))
			, attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestCase.java|(1213,26,<31,1>,<31,26>))
			, attr("name", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestCase.java|(1242,27,<32,1>,<32,27>))
			, attr("prerequisites", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestCase.java|(1305,36,<34,1>,<34,36>))
			, attr("purpose", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestCase.java|(1272,30,<33,1>,<33,30>))
			, attr("testData", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestCase.java|(1344,31,<35,1>,<35,31>))
		],
		[
			asso("project", "Project", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestCase.java|(1413,31,<37,1>,<37,31>))
			, asso("comments", "Comment", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestCase.java|(1447,38,<38,1>,<38,38>))
			, asso("steps", "Event", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestCase.java|(1488,33,<39,1>,<39,33>))
			, asso("testRuns", "TestRun", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestCase.java|(1524,38,<40,1>,<40,38>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestCase.java|(1153,7318,<28,0>,<313,0>)
		)
	, class("TestFolder",
		[
			attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestFolder.java|(1148,26,<30,1>,<30,26>))
			, attr("name", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestFolder.java|(1177,27,<31,1>,<31,27>))
		],
		[
			asso("testPlan", "TestPlan", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestFolder.java|(1248,33,<33,1>,<33,33>))
			, asso("testRuns", "TestRun", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestFolder.java|(1207,38,<32,1>,<32,38>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestFolder.java|(1090,2325,<28,0>,<123,0>)
		)
	, class("TestPlan",
		[
			attr("createdBy", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestPlan.java|(1368,32,<35,1>,<35,32>))
			, attr("folders", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestPlan.java|(1335,30,<34,1>,<34,30>))
			, attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestPlan.java|(1276,26,<32,1>,<32,26>))
			, attr("name", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestPlan.java|(1305,27,<33,1>,<33,27>))
		],
		[
			asso("project", "Project", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestPlan.java|(1444,31,<37,1>,<37,31>))
			, asso("testFolders", "TestFolder", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestPlan.java|(1478,44,<38,1>,<38,44>))
			, asso("testRuns", "TestRun", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestPlan.java|(1403,38,<36,1>,<36,38>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestPlan.java|(1188,8570,<29,0>,<329,0>)
		)
	, class("TestRun",
		[
			attr("executionDate", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestRun.java|(1375,34,<36,1>,<36,34>))
			, attr("folder", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestRun.java|(1412,29,<37,1>,<37,29>))
			, attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestRun.java|(1314,26,<34,1>,<34,26>))
			, attr("status", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestRun.java|(1343,29,<35,1>,<35,29>))
		],
		[
			asso("testCase", "TestCase", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestRun.java|(1480,33,<39,1>,<39,33>))
			, asso("testPlan", "TestPlan", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestRun.java|(1444,33,<38,1>,<38,33>))
			, asso("comments", "Comment", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestRun.java|(1516,38,<40,1>,<40,38>))
			, asso("projectMembers", "ProjectMember", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestRun.java|(1557,49,<41,1>,<41,49>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/TestRun.java|(1227,5638,<31,0>,<243,0>)
		)
	, class("UseCase",
		[
			attr("postconditions", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/UseCase.java|(1324,37,<34,1>,<34,37>))
			, attr("preconditions", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/UseCase.java|(1285,36,<33,1>,<33,36>))
			, attr("type", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/UseCase.java|(1255,27,<32,1>,<32,27>))
		],
		[
			asso("extend", "UseCase", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/UseCase.java|(1506,30,<39,1>,<39,30>))
			, asso("include", "UseCase", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/UseCase.java|(1472,31,<38,1>,<38,31>))
			, asso("actors", "Actor", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/UseCase.java|(1436,33,<37,1>,<37,33>))
			, asso("events", "Event", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/UseCase.java|(1364,34,<35,1>,<35,34>))
			, asso("tasks", "Task", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/UseCase.java|(1401,32,<36,1>,<36,32>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/UseCase.java|(1176,9731,<29,0>,<384,0>)
		)
	, class("Version",
		[
			attr("file", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Version.java|(1187,27,<31,1>,<31,27>))
			, attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Version.java|(1125,26,<29,1>,<29,26>))
			, attr("number", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Version.java|(1154,30,<30,1>,<30,30>))
		],
		[
			asso("document", "Document", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Version.java|(1217,33,<32,1>,<32,33>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/Version.java|(1098,2456,<27,0>,<123,0>)
		)
	, class("WorkProduct",
		[
			attr("createdBy", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/WorkProduct.java|(1574,32,<42,1>,<42,32>))
			, attr("description", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/WorkProduct.java|(1608,34,<43,1>,<43,34>))
			, attr("endDate", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/WorkProduct.java|(1544,28,<41,1>,<41,28>))
			, attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/WorkProduct.java|(1422,26,<37,1>,<37,26>))
			, attr("label", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/WorkProduct.java|(1779,28,<48,1>,<48,28>))
			, attr("name", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/WorkProduct.java|(1450,27,<38,1>,<38,27>))
			, attr("priority", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/WorkProduct.java|(1746,31,<47,1>,<47,31>))
			, attr("progress", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/WorkProduct.java|(1644,32,<44,1>,<44,32>))
			, attr("startDate", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/WorkProduct.java|(1512,30,<40,1>,<40,30>))
			, attr("status", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/WorkProduct.java|(1715,29,<46,1>,<46,29>))
		],
		[
			asso("iteration", "Iteration", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/WorkProduct.java|(1678,35,<45,1>,<45,35>))
			, asso("project", "Project", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/WorkProduct.java|(1479,31,<39,1>,<39,31>))
			, asso("attachments", "Attachment", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/WorkProduct.java|(1902,44,<52,1>,<52,44>))
			, asso("comments", "Comment", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/WorkProduct.java|(1948,38,<53,1>,<53,38>))
			, asso("documents", "Document", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/WorkProduct.java|(1861,39,<51,1>,<51,39>))
			, asso("projectMembers", "ProjectMember", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/WorkProduct.java|(1810,49,<50,1>,<50,49>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/WorkProduct.java|(1338,15789,<34,0>,<561,0>)
		)
	, class("email.Email",
		[
			attr("fromAddress", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/email/Email.java|(1299,34,<35,1>,<35,34>))
			, attr("hasConnection", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/email/Email.java|(1372,38,<37,1>,<37,38>))
			, attr("mailSession", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/email/Email.java|(1454,35,<39,1>,<39,35>))
			, attr("protocol", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/email/Email.java|(1336,33,<36,1>,<36,33>))
			, attr("setupIsCorrect", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/email/Email.java|(1413,38,<38,1>,<38,38>))
			, attr("transport", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/email/Email.java|(1492,35,<40,1>,<40,35>))
		],
		[
			asso("email", "email.Email", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/email/Email.java|(1532,34,<42,1>,<42,34>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/email/Email.java|(1274,3541,<33,0>,<134,0>)
		)
	, class("email.EmailCourier",
		[
			attr("description", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/email/EmailCourier.java|(1222,34,<31,1>,<31,34>))
			, attr("id", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/email/EmailCourier.java|(1162,26,<29,1>,<29,26>))
			, attr("label", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/email/EmailCourier.java|(1191,28,<30,1>,<30,28>))
			, attr("name", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/email/EmailCourier.java|(1259,27,<32,1>,<32,27>))
		],
		[
			asso("currentProjectMembers", "ProjectMember", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/email/EmailCourier.java|(1345,56,<34,1>,<34,56>))
			, asso("newProjectMembers", "ProjectMember", |project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/email/EmailCourier.java|(1289,53,<33,1>,<33,53>))
		],
		|project://Endeavour-Mgmt/model/org/endeavour/mgmt/model/email/EmailCourier.java|(1115,3448,<27,0>,<115,0>)
		)
};