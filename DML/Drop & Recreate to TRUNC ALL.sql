-- DELETE FKS, DROP ALL TABLES IN PAT SCHEMA & RECREATE TO TRUNCATE ALL

--DELETE ALL FKs
ALTER TABLE PMPAD.pat.activities DROP CONSTRAINT activities_FK_status;
ALTER TABLE PMPAD.pat.activities DROP CONSTRAINT activities_FK_compound;
ALTER TABLE PMPAD.pat.activities DROP CONSTRAINT activities_FK_created_by;
ALTER TABLE PMPAD.pat.activities DROP CONSTRAINT activities_FK_team_id;
ALTER TABLE PMPAD.pat.activity_parameter_accrual_item DROP CONSTRAINT activity_parameter_accrual_item_FK_time_period;
ALTER TABLE PMPAD.pat.activity_parameter_accrual_item DROP CONSTRAINT activity_parameter_accrual_item_FK_activity_param;
ALTER TABLE PMPAD.pat.activity_parameter_accrual_item DROP CONSTRAINT activity_parameter_accrual_item_FK_last_updated;
ALTER TABLE PMPAD.pat.activity_parameter_forecast_item DROP CONSTRAINT activity_parameter_forecast_item_FK_time_period;
ALTER TABLE PMPAD.pat.activity_parameter_forecast_item DROP CONSTRAINT activity_parameter_forecast_item_FK_last_updated;
ALTER TABLE PMPAD.pat.activity_parameter_forecast_item DROP CONSTRAINT activity_parameter_forecast_item_FK_activity_param;
ALTER TABLE PMPAD.pat.activity_parameters DROP CONSTRAINT activity_parameters_FK_activity;
ALTER TABLE PMPAD.pat.activity_parameters DROP CONSTRAINT activity_parameters_FK_params;
ALTER TABLE PMPAD.pat.contract_parameters DROP CONSTRAINT contract_parameters_FK_param;
ALTER TABLE PMPAD.pat.contract_parameters DROP CONSTRAINT contract_parameters_FK_po;
ALTER TABLE PMPAD.pat.parameters DROP CONSTRAINT parameters_FK_phase;
ALTER TABLE PMPAD.pat.po_activities DROP CONSTRAINT po_activities_FK_activity;
ALTER TABLE PMPAD.pat.po_activities DROP CONSTRAINT po_activities_FK_purchase_orders;
ALTER TABLE PMPAD.pat.purchase_orders DROP CONSTRAINT purchase_orders_FK_doc_type;
ALTER TABLE PMPAD.pat.purchase_orders DROP CONSTRAINT purchase_orders_FK_party_id;
ALTER TABLE PMPAD.pat.purchase_orders DROP CONSTRAINT purchase_orders_FK_status;
ALTER TABLE PMPAD.pat.po_change_orders DROP CONSTRAINT po_change_orders_FK_doc_type;
ALTER TABLE PMPAD.pat.po_change_orders DROP CONSTRAINT po_change_orders_FK_po;
ALTER TABLE PMPAD.pat.po_lines DROP CONSTRAINT po_lines_FK_dept;
ALTER TABLE PMPAD.pat.po_lines DROP CONSTRAINT po_lines_FK_po_activity;
ALTER TABLE PMPAD.pat.task_items DROP CONSTRAINT task_items_FK_change_order;
ALTER TABLE PMPAD.pat.task_items DROP CONSTRAINT task_items_FK_task;
ALTER TABLE PMPAD.pat.tasks DROP CONSTRAINT tasks_FK_activity_param;
ALTER TABLE PMPAD.pat.tasks DROP CONSTRAINT tasks_FK_contract_param;
ALTER TABLE PMPAD.pat.tasks DROP CONSTRAINT tasks_FK_created_by;
ALTER TABLE PMPAD.pat.tasks DROP CONSTRAINT tasks_FK_expense_type;
ALTER TABLE PMPAD.pat.tasks DROP CONSTRAINT tasks_FK_po_line;
ALTER TABLE PMPAD.pat.users DROP CONSTRAINT users_FK_role;
ALTER TABLE PMPAD.pat.vendor_invoice_details DROP CONSTRAINT vendor_invoice_details_FK_invoice;
ALTER TABLE PMPAD.pat.vendor_invoice_details DROP CONSTRAINT vendor_invoice_details_FK_po_line;

--DROP ALL TABLES
DROP TABLE PMPAD.pat.compounds;
DROP TABLE PMPAD.pat.departments;
DROP TABLE PMPAD.pat.document_type_list;
DROP TABLE PMPAD.pat.expense_type;
DROP TABLE PMPAD.pat.fiscal_time_periods;
DROP TABLE PMPAD.pat.project_phase;
DROP TABLE PMPAD.pat.roles;
DROP TABLE PMPAD.pat.services;
DROP TABLE PMPAD.pat.status;
DROP TABLE PMPAD.pat.parties;
DROP TABLE PMPAD.pat.activities;
DROP TABLE PMPAD.pat.activity_budget_approvals;
DROP TABLE PMPAD.pat.activity_parameter_accrual_item;
DROP TABLE PMPAD.pat.activity_parameter_forecast_item;
DROP TABLE PMPAD.pat.activity_parameters;
DROP TABLE PMPAD.pat.contract_parameters;
DROP TABLE PMPAD.pat.parameters;
DROP TABLE PMPAD.pat.po_activities;
DROP TABLE PMPAD.pat.po_change_orders;
DROP TABLE PMPAD.pat.po_lines;
DROP TABLE PMPAD.pat.purchase_orders;
DROP TABLE PMPAD.pat.users;
DROP TABLE PMPAD.pat.task_items;
DROP TABLE PMPAD.pat.tasks;
DROP TABLE PMPAD.pat.vendor_invoice_details;
DROP TABLE PMPAD.pat.vendor_invoices;

--CREATE ALL LOOKUP TABLES
--compounds
CREATE TABLE PMPAD.pat.compounds (
	compound_id int IDENTITY(1,1) NOT NULL,
	compound_name nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	pa_assignment nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	oracle_id nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	creation_dtm datetime DEFAULT getdate() NULL,
	is_active bit DEFAULT 1 NULL,
	old_compound_id nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_pkid int NULL,
	CONSTRAINT PK__compound__3213E83F62B6A00D PRIMARY KEY (compound_id)
);

--departments
CREATE TABLE PMPAD.pat.departments (
	department_id int IDENTITY(1,1) NOT NULL,
	department_name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	cost_center varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	creation_dtm datetime DEFAULT getdate() NULL,
	is_active bit DEFAULT 1 NULL,
	old_department_id nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_pkid int NULL,
	CONSTRAINT departments_PK PRIMARY KEY (department_id)
);

--document_type_list
CREATE TABLE PMPAD.pat.document_type_list (
	document_type_id int IDENTITY(1,1) NOT NULL,
	document_type nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	creation_dtm datetime DEFAULT getdate() NULL,
	is_active bit DEFAULT 1 NULL,
	old_coad_doc_type_id nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_pkid int NULL,
	CONSTRAINT document_type_list_PK PRIMARY KEY (document_type_id)
);

--expense_type
CREATE TABLE PMPAD.pat.expense_type (
	expense_type_id int IDENTITY(1,1) NOT NULL,
	expense_type nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	creation_dtm datetime DEFAULT getdate() NULL,
	is_active bit DEFAULT 1 NULL,
	old_expense_type_id nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_pkid int NULL,
	CONSTRAINT PK__expense___3213E83F407E909D PRIMARY KEY (expense_type_id)
);

--fiscal_time_periods
CREATE TABLE PMPAD.pat.fiscal_time_periods (
	time_period_id int IDENTITY(1,1) NOT NULL,
	month_year date NULL,
	accounting_year varchar(16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	accounting_month nvarchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	accounting_quarter varchar(6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	creation_date datetime DEFAULT getdate() NULL,
	CONSTRAINT PK__fiscal_t__30964F03E882ADCE PRIMARY KEY (time_period_id)
);

--parties
CREATE TABLE PMPAD.pat.parties (
	party_id int IDENTITY(1,1) NOT NULL,
	party_name nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	discoverer_vendor_id nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_party_id nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_pkid int NULL,
	CONSTRAINT PK__parties__3213E83F49D80F7B PRIMARY KEY (party_id)
);

--project_phase
CREATE TABLE PMPAD.pat.project_phase (
	project_phase_id int IDENTITY(1,1) NOT NULL,
	project_phase_name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	creation_dtm datetime DEFAULT getdate() NULL,
	is_active bit DEFAULT 1 NULL,
	CONSTRAINT project_phase_PK PRIMARY KEY (project_phase_id)
);

--roles
CREATE TABLE PMPAD.pat.roles (
	role_id int NOT NULL,
	role_description varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT roles_PK PRIMARY KEY (role_id)
);

--services
CREATE TABLE PMPAD.pat.services (
	service_id int IDENTITY(1,1) NOT NULL,
	service_desc nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	cost_account nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	additional_notes nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	creation_dtm datetime DEFAULT getdate() NULL,
	is_active bit DEFAULT 1 NULL,
	created_by int NULL,
	old_service_id nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_pkid int NULL,
	CONSTRAINT PK__services__3213E83F802A2841 PRIMARY KEY (service_id)
);

--status
CREATE TABLE PMPAD.pat.status (
	status_id int IDENTITY(1,1) NOT NULL,
	status_desc nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	help_text nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	creation_dtm datetime DEFAULT getdate() NULL,
	is_active bit DEFAULT 1 NULL,
	old_protocol_status_id nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_pkid int NULL,
	CONSTRAINT PK__protocol__3213E83FBDCDB57D PRIMARY KEY (status_id)
);

--CREATE ALL COMBO TABLES

--users
CREATE TABLE PMPAD.pat.users (
	user_id int IDENTITY(1,1) NOT NULL,
	role_id int NULL,
	username nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	first_name nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	last_name nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	creation_dtm datetime DEFAULT getdate() NULL,
	is_active bit DEFAULT 1 NULL,
	created_by int NULL,
	old_user_id nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_pkid int NULL,
	CONSTRAINT PK__users__3213E83F479272F1 PRIMARY KEY (user_id),
	CONSTRAINT users_FK_role FOREIGN KEY (role_id) REFERENCES PMPAD.pat.roles(role_id)
);

--parameters
CREATE TABLE PMPAD.pat.parameters (
	parameter_id int IDENTITY(1,1) NOT NULL,
	project_phase_id int NULL,
	demographic_parameter nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order] float NULL,
	creation_dtm datetime DEFAULT getdate() NULL,
	is_active bit DEFAULT 1 NULL,
	created_by int NULL,
	old_demopar_id varchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_pkid int NULL,
	CONSTRAINT PK__demograp__3213E83F09D4FE62 PRIMARY KEY (parameter_id),
	CONSTRAINT parameters_FK_phase FOREIGN KEY (project_phase_id) REFERENCES PMPAD.pat.project_phase(project_phase_id) ON UPDATE CASCADE
);

--activities
CREATE TABLE PMPAD.pat.activities (
	activity_id int IDENTITY(1,1) NOT NULL,
	status_id int NULL,
	compound_id int NULL,
	created_by int NULL,
	team_id int NULL,
	grdb_code nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	hyperion_code nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	activity_description nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	protocol_number nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	study_objective nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	comments nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	planisware_study_code nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	planisware_project_code nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	creation_dtm datetime DEFAULT getdate() NULL,
	is_active bit DEFAULT 1 NULL,
	old_activity_id varchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_pkid int NULL,
	activity_start_date date NULL,
	activity_end_date date NULL,
	CONSTRAINT PK__activiti__3213E83FCEB9C61E PRIMARY KEY (activity_id),
	CONSTRAINT activities_FK_status FOREIGN KEY (status_id) REFERENCES PMPAD.pat.status(status_id),
	CONSTRAINT activities_FK_compound FOREIGN KEY (compound_id) REFERENCES PMPAD.pat.compounds(compound_id),
	CONSTRAINT activities_FK_created_by FOREIGN KEY (created_by) REFERENCES PMPAD.pat.users(user_id),
	CONSTRAINT activities_FK_team_id FOREIGN KEY (team_id) REFERENCES PMPAD.pat.users(user_id)
);


--activity_budget_approvals
CREATE TABLE PMPAD.pat.activity_budget_approvals (
	activity_budget_approval_id int IDENTITY(1,1) NOT NULL,
	budget_approval_amount money NULL,
	approval_date datetime NULL,
	link_to_documentation nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	comments nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	parent_id nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	activity_id nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	supplier nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	currency nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	objective nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	proposal nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	application_version nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	creation_dtm datetime DEFAULT getdate() NULL,
	is_active bit DEFAULT 1 NULL,
	created_by int NULL,
	old_proj_approval_id nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_pkid int NULL,
	CONSTRAINT PK__activity__3213E83F4DABB113 PRIMARY KEY (activity_budget_approval_id)
);

--activity_parameters
CREATE TABLE PMPAD.pat.activity_parameters (
	activity_parameter_id int IDENTITY(1,1) NOT NULL,
	activity_id int NOT NULL,
	parameter_id int NOT NULL,
	activity_parameter_comments varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_activity_parameter_id varchar(127) NOT NULL,
	CONSTRAINT activity_parameters_PK PRIMARY KEY (activity_parameter_id),
	CONSTRAINT activity_parameters_FK_activity FOREIGN KEY (activity_id) REFERENCES PMPAD.pat.activities(activity_id),
	CONSTRAINT activity_parameters_FK_params FOREIGN KEY (parameter_id) REFERENCES PMPAD.pat.parameters(parameter_id)
);

--activity_parameter_accrual_item
CREATE TABLE PMPAD.pat.activity_parameter_accrual_item (
	time_period_id int NOT NULL,
	activity_parameter_id int NOT NULL,
	accrual_value float NULL,
	last_updated_by_id int DEFAULT 1 NULL,
	last_updated_date datetime DEFAULT getdate() NULL,
	accrual_comments varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT activity_parameter_accrual_item_PK PRIMARY KEY (time_period_id,activity_parameter_id),
	CONSTRAINT activity_parameter_accrual_item_FK_time_period FOREIGN KEY (time_period_id) REFERENCES PMPAD.pat.fiscal_time_periods(time_period_id),
	CONSTRAINT activity_parameter_accrual_item_FK_activity_param FOREIGN KEY (activity_parameter_id) REFERENCES PMPAD.pat.activity_parameters(activity_parameter_id),
	CONSTRAINT activity_parameter_accrual_item_FK_last_updated FOREIGN KEY (last_updated_by_id) REFERENCES PMPAD.pat.users(user_id)
);

--activity_parameter_forecast_item
CREATE TABLE PMPAD.pat.activity_parameter_forecast_item (
	time_period_id int NOT NULL,
	activity_parameter_id int NOT NULL,
	forecast_value float NULL,
	last_updated_by_id int DEFAULT 1 NULL,
	last_updated_date datetime DEFAULT getdate() NULL,
	forecast_comments varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT activity_parameter_forecast_item_PK PRIMARY KEY (time_period_id,activity_parameter_id),
	CONSTRAINT activity_parameter_forecast_item_FK_time_period FOREIGN KEY (time_period_id) REFERENCES PMPAD.pat.fiscal_time_periods(time_period_id),
	CONSTRAINT activity_parameter_forecast_item_FK_last_updated FOREIGN KEY (last_updated_by_id) REFERENCES PMPAD.pat.users(user_id),
	CONSTRAINT activity_parameter_forecast_item_FK_activity_param FOREIGN KEY (activity_parameter_id) REFERENCES PMPAD.pat.activity_parameters(activity_parameter_id)
);

--purchase_orders
CREATE TABLE PMPAD.pat.purchase_orders (
	purchase_order_id int IDENTITY(1,1) NOT NULL,
	document_type_id int NULL,
	party_id int NULL,
	status_id int NULL,
	po_number nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	po_description nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	received_dtm datetime NULL,
	executed_dtm datetime NULL,
	po_document_copy nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	po_comments nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	po_payment_term nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_purchase_order_id nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_pkid int NULL,
	CONSTRAINT PK__purchase__3213E83F7498A4CF PRIMARY KEY (purchase_order_id),
	CONSTRAINT purchase_orders_FK_doc_type FOREIGN KEY (document_type_id) REFERENCES PMPAD.pat.document_type_list(document_type_id),
	CONSTRAINT purchase_orders_FK_party_id FOREIGN KEY (party_id) REFERENCES PMPAD.pat.parties(party_id),
	CONSTRAINT purchase_orders_FK_status FOREIGN KEY (status_id) REFERENCES PMPAD.pat.status(status_id)
);

--po_change_orders
CREATE TABLE PMPAD.pat.po_change_orders (
	po_change_order_id int IDENTITY(1,1) NOT NULL,
	document_type_id int NULL,
	purchase_order_id int NULL,
	co_executed_dtm datetime NULL,
	co_document_copy nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	co_comments nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	creation_dtm datetime DEFAULT getdate() NULL,
	is_active bit DEFAULT 1 NULL,
	created_by int NULL,
	old_co_id nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_pkid int NULL,
	CONSTRAINT PK__po_chang__3213E83F92FD374E PRIMARY KEY (po_change_order_id),
	CONSTRAINT po_change_orders_FK_doc_type FOREIGN KEY (document_type_id) REFERENCES PMPAD.pat.document_type_list(document_type_id),
	CONSTRAINT po_change_orders_FK_po FOREIGN KEY (purchase_order_id) REFERENCES PMPAD.pat.purchase_orders(purchase_order_id)
);

--contract_parameters
CREATE TABLE PMPAD.pat.contract_parameters (
	contract_parameter_id int IDENTITY(1,1) NOT NULL,
	parameter_id int NULL,
	purchase_order_id int NULL,
	contracted_number varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	contract_parameter_comments varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	creation_dtm datetime NULL,
	is_active bit NULL,
	created_by int NULL,
	old_contract_assumption_id nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_pkid nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT contract_parameters_PK PRIMARY KEY (contract_parameter_id),
	CONSTRAINT contract_parameters_FK_param FOREIGN KEY (parameter_id) REFERENCES PMPAD.pat.parameters(parameter_id),
	CONSTRAINT contract_parameters_FK_po FOREIGN KEY (purchase_order_id) REFERENCES PMPAD.pat.purchase_orders(purchase_order_id)
);


--po_activities
CREATE TABLE PMPAD.pat.po_activities (
	po_activity_id int IDENTITY(1,1) NOT NULL,
	activity_id int NOT NULL,
	purchase_order_id int NOT NULL,
	CONSTRAINT po_activities_PK PRIMARY KEY (po_activity_id),
	CONSTRAINT po_activities_FK_activity FOREIGN KEY (activity_id) REFERENCES PMPAD.pat.activities(activity_id),
	CONSTRAINT po_activities_FK_purchase_orders FOREIGN KEY (purchase_order_id) REFERENCES PMPAD.pat.purchase_orders(purchase_order_id)
);

--po_lines
CREATE TABLE PMPAD.pat.po_lines (
	po_line_id int IDENTITY(1,1) NOT NULL,
	department_id int NULL,
	po_activity_id int NULL,
	po_line_number nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	po_line_description nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	comments nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	creation_dtm datetime DEFAULT getdate() NULL,
	is_active bit DEFAULT 1 NULL,
	created_by int NULL,
	old_po_line_id nvarchar(127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_pkid int NULL,
	po_line_total_cost nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__po_lines__3213E83F02903061 PRIMARY KEY (po_line_id),
	CONSTRAINT po_lines_FK_dept FOREIGN KEY (department_id) REFERENCES PMPAD.pat.departments(department_id),
	CONSTRAINT po_lines_FK_po_activity FOREIGN KEY (po_activity_id) REFERENCES PMPAD.pat.po_activities(po_activity_id)
);

--tasks
CREATE TABLE PMPAD.pat.tasks (
	task_id int IDENTITY(1,1) NOT NULL,
	activity_parameter_id int NULL,
	contract_parameter_id int NULL,
	created_by int NULL,
	expense_type_id int NULL,
	po_line_id int NULL,
	budget_task_desc varchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	budget_unit_desc varchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	task_comments varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	creation_dtm datetime NULL,
	is_active bit NULL,
	old_vendor_budget_details_id nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_pkid nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT tasks_PK PRIMARY KEY (task_id),
	CONSTRAINT tasks_FK_activity_param FOREIGN KEY (activity_parameter_id) REFERENCES PMPAD.pat.activity_parameters(activity_parameter_id),
	CONSTRAINT tasks_FK_contract_param FOREIGN KEY (contract_parameter_id) REFERENCES PMPAD.pat.contract_parameters(contract_parameter_id),
	CONSTRAINT tasks_FK_created_by FOREIGN KEY (created_by) REFERENCES PMPAD.pat.users(user_id),
	CONSTRAINT tasks_FK_expense_type FOREIGN KEY (expense_type_id) REFERENCES PMPAD.pat.expense_type(expense_type_id),
	CONSTRAINT tasks_FK_po_line FOREIGN KEY (po_line_id) REFERENCES PMPAD.pat.po_lines(po_line_id)
);

--task_items
CREATE TABLE PMPAD.pat.task_items (
	task_item_id int IDENTITY(1,1) NOT NULL,
	task_id int NULL,
	change_order_id int NULL,
	budget_units varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	budget_unit_cost varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	total_cost varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	discount varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT task_items_PK PRIMARY KEY (task_item_id),
	CONSTRAINT task_items_FK_change_order FOREIGN KEY (change_order_id) REFERENCES PMPAD.pat.po_change_orders(po_change_order_id),
	CONSTRAINT task_items_FK_task FOREIGN KEY (task_id) REFERENCES PMPAD.pat.tasks(task_id)
);


--vendor_invoices
CREATE TABLE PMPAD.pat.vendor_invoices (
	vendor_invoice_id int IDENTITY(1,1) NOT NULL,
	Invoice_Date date NULL,
	Service_Period date NULL,
	Date_Received date NULL,
	Disputed_Y_N nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Coding_Status nvarchar(63) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Date_Sent_AP date NULL,
	Link_to_Invoice_Copy nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Comments nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_COAD_Invoice_AutoID nvarchar(63) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_Vendor_Invoice_ID nvarchar(63) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	old_COAD_DB_ID nvarchar(63) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_PKID int NULL,
	CONSTRAINT vendor_invoices_PK PRIMARY KEY (vendor_invoice_id)
);


--vendor_invoice_details
CREATE TABLE PMPAD.pat.vendor_invoice_details (
	vendor_invoice_detail_id int IDENTITY(1,1) NOT NULL,
	vendor_invoice_id int NOT NULL,
	po_line_id int NOT NULL,
	Original_Budget_ID nvarchar(63) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Line_Item_Amount money NOT NULL,
	Comments nvarchar(63) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_COAD_Invoice_Details_AutoID nvarchar(63) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_COAD_Invoice_ID nvarchar(63) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	old_PKID int NULL,
	old_POLineID nvarchar(63) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT vendor_invoice_details_PK PRIMARY KEY (vendor_invoice_detail_id),
	CONSTRAINT vendor_invoice_details_FK_invoice FOREIGN KEY (vendor_invoice_id) REFERENCES PMPAD.pat.vendor_invoices(vendor_invoice_id),
	CONSTRAINT vendor_invoice_details_FK_po_line FOREIGN KEY (po_line_id) REFERENCES PMPAD.pat.po_lines(po_line_id)
);