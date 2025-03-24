jadeVersionNumber "99.0.00";
schemaDefinition
BankModelSchema subschemaOf RootSchema completeDefinition;
	setModifiedTimeStamp "cnwth3" "5.2.08" 2018:06:15:14:41:34;
constantDefinitions
	categoryDefinition ModelErrorCodes
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		InvalidDirectoryPath:          Integer = 150019;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		JErr_Regex_Failed_User:        Integer = 8950;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
localeDefinitions
	5129 "English (New Zealand)" schemaDefaultLocale;
	setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	1033 "English (United States)" _cloneOf 5129;
	setModifiedTimeStamp "<unknown>" "" 2024:11:05:10:35:05;
typeHeaders
	BankModelSchema subclassOf RootSchemaApp transient, sharedTransientAllowed, transientAllowed, subclassSharedTransientAllowed, subclassTransientAllowed, highestOrdinal = 2, number = 8441;
	Bank subclassOf Object highestSubId = 4, highestOrdinal = 5, number = 8443;
	BankEntity subclassOf Object number = 8444;
	Account subclassOf BankEntity highestSubId = 1, highestOrdinal = 8, number = 8445;
	Card subclassOf BankEntity number = 8446;
	Customer subclassOf BankEntity highestOrdinal = 18, number = 8447;
	District subclassOf BankEntity highestSubId = 2, highestOrdinal = 9, number = 8448;
	Institute subclassOf BankEntity number = 8449;
	Loan subclassOf BankEntity number = 8450;
	Order subclassOf BankEntity number = 8451;
	Transaction subclassOf BankEntity highestOrdinal = 11, number = 8452;
	DataLoader subclassOf Object highestOrdinal = 2, number = 8453;
	GFCModelSchema subclassOf RootSchemaGlobal transient, sharedTransientAllowed, transientAllowed, subclassSharedTransientAllowed, subclassTransientAllowed, highestOrdinal = 1, number = 8454;
	SFCModelSchema subclassOf RootSchemaSession transient, sharedTransientAllowed, transientAllowed, subclassSharedTransientAllowed, subclassTransientAllowed, number = 8459;
	AccountByIdDict subclassOf MemberKeyDictionary loadFactor = 66, number = 8460;
	CustomerByIdDict subclassOf MemberKeyDictionary loadFactor = 66, number = 8461;
	DistrictByIdDict subclassOf MemberKeyDictionary loadFactor = 66, number = 8462;
	TransactionByIdDict subclassOf MemberKeyDictionary loadFactor = 66, number = 8522;
membershipDefinitions
	AccountByIdDict of Account;
	CustomerByIdDict of Customer;
	DistrictByIdDict of District;
	TransactionByIdDict of Transaction;
typeDefinitions
	Object completeDefinition
	(
	)
	Application completeDefinition
	(
	)
	RootSchemaApp completeDefinition
	(
	)
	BankModelSchema completeDefinition
	(
		setModifiedTimeStamp "cnwth3" "99.0.00" 2025:02:27:10:05:26.741;
	referenceDefinitions
		msgLog:                        JadeLog  number = 2, ordinal = 2;
		setModifiedTimeStamp "cnwjbl6" "22.0.00" 2024:06:06:10:03:56.675;
		myRoot:                        Bank  number = 1, ordinal = 1;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	jadeMethodDefinitions
		logMessage(s: String) updating, number = 1004;
		setModifiedTimeStamp "cnwjbl6" "22.0.00" 2024:08:27:15:58:28.876;
		raiseModelException(errorNo: Integer) number = 1001;
		setModifiedTimeStamp "cnwth3" "99.0.00" 2025:02:27:10:07:22.896;
	)
	Bank completeDefinition
	(
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	attributeDefinitions
		name:                          String[101] protected, number = 1, ordinal = 1;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	referenceDefinitions
		allAccounts:                   AccountByIdDict   explicitInverse, readonly, subId = 1, number = 2, ordinal = 2;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		allCustomers:                  CustomerByIdDict   explicitInverse, readonly, subId = 2, number = 3, ordinal = 3;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		allDistricts:                  DistrictByIdDict   explicitInverse, subId = 3, number = 4, ordinal = 4;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		allTransactions:               TransactionByIdDict   explicitInverse, readonly, subId = 4, number = 5, ordinal = 5;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	jadeMethodDefinitions
		create(name: String) updating, number = 1001;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		createAccount(
			id: String; 
			district_id: Integer; 
			frequency: String; 
			date: Date): Account number = 1002;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		createCustomer(
			id: String; 
			gender: String; 
			social: String; 
			firstName: String; 
			middleName: String; 
			lastName: String; 
			phone: String; 
			email: String; 
			address_1: String; 
			address_2: String; 
			city: String; 
			state: String; 
			zipcode: String; 
			district_id: Integer; 
			dob: Date) number = 1003;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		createDistrict(
			id: Integer; 
			city: String; 
			stateName: String; 
			stateAbbrev: String; 
			region: String; 
			division: String): District number = 1004;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		createTransaction(
			id: String; 
			timestamp: TimeStamp; 
			account_id: String; 
			type: String; 
			operation: String; 
			amount: Decimal; 
			k_symbol: String; 
			otherBank: String; 
			otherAccount: String): Transaction number = 1005;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		getAccountById(id: String): Account number = 1006;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		getDistrictById(id: Integer): District number = 1007;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		updateAccounts(doAbort: Boolean) number = 1008;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		updateCustomerSlobs() number = 1009;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		updateCustomers(doAbort: Boolean) number = 1010;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		updateFirstCustomer() number = 1011;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	)
	BankEntity completeDefinition
	(
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	)
	Account completeDefinition
	(
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	attributeDefinitions
		active:                        Boolean number = 1, ordinal = 1;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		date:                          Date readonly, number = 2, ordinal = 2;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		district_id:                   Integer readonly, number = 3, ordinal = 3;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		frequency:                     String[31] readonly, number = 4, ordinal = 4;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		id:                            String[13] readonly, number = 5, ordinal = 5;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	referenceDefinitions
		myBank:                        Bank   explicitEmbeddedInverse, number = 6, ordinal = 6;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		myDistrict:                    District   explicitEmbeddedInverse, number = 7, ordinal = 7;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		myTransactions:                TransactionByIdDict   explicitInverse, readonly, subId = 1, number = 8, ordinal = 8;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	jadeMethodDefinitions
		create(
			id: String; 
			district_id: Integer; 
			frequency: String; 
			date: Date; 
			parent: Bank; 
			district: District) updating, number = 1001;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	)
	Card completeDefinition
	(
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	)
	Customer completeDefinition
	(
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	attributeDefinitions
		active:                        Boolean number = 1, ordinal = 1;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		address_1:                     String subId = 1, number = 2, ordinal = 2;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		address_2:                     String subId = 2, number = 3, ordinal = 3;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		city:                          String[31] number = 4, ordinal = 4;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		dateOfBirth:                   Date number = 5, ordinal = 5;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		district_id:                   Integer number = 6, ordinal = 6;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		email:                         String[61] number = 7, ordinal = 7;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		firstName:                     String[31] number = 8, ordinal = 8;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		gender:                        String[7] number = 9, ordinal = 9;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		id:                            String[13] number = 10, ordinal = 10;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		lastName:                      String[31] number = 11, ordinal = 11;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		middleName:                    String[31] number = 12, ordinal = 12;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		phoneNumber:                   String[21] number = 13, ordinal = 13;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		ssn:                           String[13] number = 14, ordinal = 14;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		state:                         String[31] number = 15, ordinal = 15;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		zipCode:                       String[13] number = 16, ordinal = 16;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	referenceDefinitions
		myBank:                        Bank   explicitEmbeddedInverse, number = 17, ordinal = 17;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		myDistrict:                    District   explicitEmbeddedInverse, number = 18, ordinal = 18;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	jadeMethodDefinitions
		create(
			id: String; 
			gender: String; 
			social: String; 
			firstName: String; 
			middleName: String; 
			lastName: String; 
			phone: String; 
			email: String; 
			address_1: String; 
			address_2: String; 
			city: String; 
			state: String; 
			zipcode: String; 
			district_id: Integer; 
			date: Date; 
			parent: Bank; 
			district: District) updating, number = 1001;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	)
	District completeDefinition
	(
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	attributeDefinitions
		city:                          String[31] number = 1, ordinal = 1;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		division:                      String[21] number = 2, ordinal = 2;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		id:                            Integer number = 3, ordinal = 3;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		region:                        String[13] number = 4, ordinal = 4;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		stateAbbrev:                   String[4] number = 5, ordinal = 5;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		stateName:                     String[31] number = 6, ordinal = 6;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	referenceDefinitions
		allAccounts:                   AccountByIdDict   explicitInverse, subId = 1, number = 7, ordinal = 7;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		allCustomers:                  CustomerByIdDict   explicitInverse, subId = 2, number = 8, ordinal = 8;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		myBank:                        Bank   explicitEmbeddedInverse, number = 9, ordinal = 9;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	jadeMethodDefinitions
		create(
			id: Integer; 
			city: String; 
			stateName: String; 
			stateAbbrev: String; 
			region: String; 
			division: String; 
			parent: Bank) updating, number = 1001;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	)
	Institute completeDefinition
	(
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	)
	Loan completeDefinition
	(
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	)
	Order completeDefinition
	(
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	)
	Transaction completeDefinition
	(
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	attributeDefinitions
		account_id:                    String[13] number = 1, ordinal = 1;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		amount:                        Decimal[15,2] number = 2, ordinal = 2;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		id:                            String[13] number = 3, ordinal = 3;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		k_symbol:                      String[26] number = 4, ordinal = 4;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		operation:                     String[31] number = 5, ordinal = 5;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		otherAccount:                  String[16] number = 6, ordinal = 6;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		otherBank:                     String[31] number = 7, ordinal = 7;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		timestamp:                     TimeStamp number = 8, ordinal = 8;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		type:                          String[11] number = 9, ordinal = 9;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	referenceDefinitions
		myAccount:                     Account   explicitEmbeddedInverse, number = 10, ordinal = 10;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		myBank:                        Bank   explicitEmbeddedInverse, number = 11, ordinal = 11;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	jadeMethodDefinitions
		create(
			id: String; 
			timestamp: TimeStamp; 
			account_id: String; 
			type: String; 
			operation: String; 
			amount: Decimal; 
			k_symbol: String; 
			otherBank: String; 
			otherAccount: String; 
			parent: Bank; 
			account: Account) updating, number = 1001;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	)
	DataLoader completeDefinition
	(
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	attributeDefinitions
		dataDirectory:                 String[301] protected, number = 1, ordinal = 1;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	referenceDefinitions
		myRoot:                        Bank  protected, number = 2, ordinal = 2;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	jadeMethodDefinitions
		closeJournal() protected, number = 1001;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		convertToTimeStamp(string: String): TimeStamp protected, number = 1002;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		create() updating, number = 1003;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		getElapsedTimeString(startClock: Integer): String typeMethod, number = 1004;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		handlException(
			e: Exception; 
			currentRecord: String): Integer protected, number = 1005;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		loadAccount(attributes: JadeRegexResult) protected, number = 1006;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		loadCustomer(attributes: JadeRegexResult) protected, number = 1007;
		setModifiedTimeStamp "cnwjbl6" "22.0.00" 2024:06:05:16:30:31.192;
		loadData(directoryPath: String) updating, number = 1008;
		setModifiedTimeStamp "cnwjbl6" "22.0.00" 2024:09:16:11:40:33.335;
		loadDistrict(attributes: JadeRegexResult) protected, number = 1009;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		loadRecords(
			fileName: String; 
			loadRecordMethod: JadeMethod; 
			commitModulus: Integer) protected, number = 1010;
		setModifiedTimeStamp "cnwth3" "99.0.00" 2025:02:27:10:01:13.144;
		loadTransaction(attributes: JadeRegexResult) protected, number = 1011;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		makeBank(name: String) updating, protected, number = 1012;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		validateDirectoryPath(directoryPath: String): String protected, number = 1013;
		setModifiedTimeStamp "cnwth3" "99.0.00" 2025:02:27:10:07:24.102;
	)
	Global completeDefinition
	(
	)
	RootSchemaGlobal completeDefinition
	(
	)
	GFCModelSchema completeDefinition
	(
		setModifiedTimeStamp "cnwth3" "99.0.00" 2025:02:27:10:00:23.419;
	)
	JadeScript completeDefinition
	(
	jadeMethodDefinitions
		closeJournal() number = 1001;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		generateDesc() number = 1017;
		setModifiedTimeStamp "cnwjbl6" "22.0.00" 2024:06:05:17:45:27.205;
		getCurrentJournalOffset(
			currentJournal: Integer64 output; 
			currentOffset: Integer64 output) number = 1002;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		loadData() number = 1003;
		setModifiedTimeStamp "cnwth3" "99.0.00" 2025:02:27:10:02:13.364;
		purgeCustomers() number = 1004;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		purgeData() number = 1005;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		purgeTransactions() number = 1007;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		setCaptureState() number = 1009;
		setModifiedTimeStamp "cnwth3" "99.0.00" 2025:02:27:10:02:51.474;
		startCapture() serverExecution, number = 1010;
		setModifiedTimeStamp "cnwjbl6" "22.0.00" 2024:07:17:13:58:39.662;
		startCaptureAtCurrent() number = 1011;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		stopCapture() serverExecution, number = 1012;
		setModifiedTimeStamp "cnwjbl6" "22.0.00" 2024:07:17:14:00:57.460;
		updateAccounts() number = 1013;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		updateCustomerSlobs() number = 1014;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		updateCustomers() number = 1015;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
		updateFirstCustomer() number = 1016;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	)
	WebSession completeDefinition
	(
	)
	RootSchemaSession completeDefinition
	(
		setModifiedTimeStamp "<unknown>" "6.1.00" 20031119 2003:12:01:13:54:02.270;
	)
	SFCModelSchema completeDefinition
	(
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	)
	Collection completeDefinition
	(
	)
	Btree completeDefinition
	(
	)
	Dictionary completeDefinition
	(
	)
	MemberKeyDictionary completeDefinition
	(
	)
	AccountByIdDict completeDefinition
	(
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	)
	CustomerByIdDict completeDefinition
	(
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	)
	DistrictByIdDict completeDefinition
	(
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	)
	TransactionByIdDict completeDefinition
	(
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:18;
	)
	Binary completeDefinition
	(
	jadeMethodDefinitions
		init(length: Integer) updating, number = 1001;
		setModifiedTimeStamp "cnwth3" "99.0.00" 2024:08:15:13:11:13.461;
		update(length: Integer) updating, number = 1002;
		setModifiedTimeStamp "cnwth3" "99.0.00" 2024:08:15:13:11:35.914;
	)
	Date completeDefinition
	(
	jadeMethodDefinitions
		convertDate(): String number = 1001;
		setModifiedTimeStamp "cnwjbl6" "22.0.00" 2024:07:29:14:27:47.370;
	)
	String completeDefinition
	(
	jadeMethodDefinitions
		endsWith(token: String): Boolean number = 1003;
		setModifiedTimeStamp "cnwjbl6" "22.0.00" 2024:09:09:12:15:14.594;
		init(length: Integer) updating, number = 1001;
		setModifiedTimeStamp "cnwjbl6" "22.0.00" 2024:08:15:13:54:23.922;
		update(length: Integer) updating, number = 1002;
		setModifiedTimeStamp "cnwjbl6" "22.0.00" 2024:08:15:13:54:40.549;
	)
	StringUtf8 completeDefinition
	(
	jadeMethodDefinitions
		init(length: Integer) updating, number = 1001;
		setModifiedTimeStamp "cnwjbl6" "22.0.00" 2024:08:15:13:56:19.596;
		update(length: Integer) updating, number = 1002;
		setModifiedTimeStamp "cnwjbl6" "22.0.00" 2024:08:15:13:56:16.636;
	)
	TimeStamp completeDefinition
	(
	jadeMethodDefinitions
		convertTimeStamp(): String number = 1002;
		setModifiedTimeStamp "cnwjbl6" "22.0.00" 2024:07:29:14:31:09.887;
		logFormat(): String number = 1001;
		setModifiedTimeStamp "cnwjbl6" "22.0.00" 2024:06:06:10:03:35.002;
	)
	TimeStampInterval completeDefinition
	(
	jadeMethodDefinitions
		convert_RFC_Duration(rfcFormatted: String): Integer64 number = 1002;
		setModifiedTimeStamp "cnwth3" "99.0.00" 2024:10:31:15:36:31.652;
		setForTest(setSelf: Boolean): Integer64 updating, number = 1001;
		setModifiedTimeStamp "cnwth3" "99.0.00" 2024:10:31:14:32:16.722;
	)
memberKeyDefinitions
	AccountByIdDict completeDefinition
	(
		id;
	)
	CustomerByIdDict completeDefinition
	(
		id;
	)
	DistrictByIdDict completeDefinition
	(
		id;
	)
	TransactionByIdDict completeDefinition
	(
		id;
	)
inverseDefinitions
	allAccounts of Bank automaticDeferred parentOf myBank of Account manual;
	allCustomers of Bank automaticDeferred parentOf myBank of Customer manual;
	allDistricts of Bank automaticDeferred parentOf myBank of District manual;
	allTransactions of Bank automaticDeferred parentOf myBank of Transaction manual;
	allAccounts of District automatic peerOf myDistrict of Account manual;
	myTransactions of Account automaticDeferred peerOf myAccount of Transaction manual;
	allCustomers of District automatic peerOf myDistrict of Customer manual;

databaseDefinitions
	BankModelSchemaDb
	(
	setModifiedTimeStamp "cnwth3" "5.2.08" 2018:06:15:14:41:34;
	databaseFileDefinitions
		"bank_data" number = 110;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:19;
		"BankModelSchema" number = 112;
		setModifiedTimeStamp "cnwth3" "7.0.09" 2014:12:29:16:48:49.517;
		"theLOBs" number = 120;
		setModifiedTimeStamp "cnwth3" "99.0.00" 2024:08:07:12:50:23.296;
		"thePTs" number = 113;
		setModifiedTimeStamp "cnwjbl6" "22.0.00" 2024:07:17:14:14:38.010;
		"transaction" number = 114;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:19;
		"bank_default" number = 116;
		setModifiedTimeStamp "JadeLoader" "22.0.03" 2024:06:05:15:53:19;
	defaultFileDefinition "bank_default";
	classMapDefinitions
		Account in "bank_data";
		AccountByIdDict in "bank_default";
		Bank in "bank_data";
		BankEntity in "bank_default";
		BankModelSchema in "_usergui";
		Card in "bank_data";
		Customer in "bank_data";
		CustomerByIdDict in "bank_default";
		DataLoader in "bank_default";
		District in "bank_data";
		DistrictByIdDict in "bank_data";
		GFCModelSchema in "bank_default";
		Institute in "bank_data";
		Loan in "bank_data";
		Order in "bank_data";
		SFCModelSchema in "_environ";
		Transaction in "transaction";
		TransactionByIdDict in "transaction";
	)
_exposedListDefinitions
	JADE_DotNET_Exposure version=0, priorVersion=0, registryId="_CSharp_Exposure"
	setModifiedTimeStamp "<unknown>" "" 2024:08:26:10:39:31;
	(
	)
typeSources
	BankModelSchema (
	jadeMethodSources
logMessage
{
logMessage(s:String)updating;

vars

begin
	if msgLog=null then
		create msgLog;
		msgLog.fileName:="Bank_Model_Schema";
		msgLog.formatOutput:=false;
//		msgLog.maxFileSize:=1000;  // leave commented out to use value from ini file
	endif;
	
	msgLog.log(actualTimeAppServer.logFormat&" "
					&name&"/"& getInstanceIdForObject(process).String&": "
					&s&CrLf);
					
					write s;
end;
}
raiseModelException
{
raiseModelException(errorNo : Integer);

vars
	
	exceptionObject : Exception;	

begin
	create exceptionObject transient;
	exceptionObject.errorCode := errorNo;
	exceptionObject.errorItem := errorNo.String;

	raise exceptionObject;
end;
}
	)
	Bank (
	jadeMethodSources
create
{
create(name : String) updating;

vars

begin
	self.name := name;
end;
}
createAccount
{
createAccount(id : String; district_id : Integer; frequency : String; date : Date) : Account;

vars
	account : Account;
begin
	account := create Account(id, district_id, frequency, date, self, getDistrictById(district_id));
	return account;
end;
}
createCustomer
{
createCustomer(id : String; gender: String; social : String; firstName: String; middleName : String; lastName : String; phone: String;  email: String; address_1 : String; address_2 : String; city : String; state : String; zipcode : String; district_id: Integer;  dob : Date);

vars
	client : Customer;
begin
	client := create Customer(id, gender, social, firstName, middleName, lastName, phone, email, address_1, address_2, city, state, zipcode, district_id, dob, self, getDistrictById(district_id));
end;
}
createDistrict
{
createDistrict(id : Integer; city : String; stateName : String; stateAbbrev : String; region : String; division : String) : District;

vars
	district : District;
begin
	district := create District(id, city, stateName, stateAbbrev, region, division, self);
	return district;
end;
}
createTransaction
{
createTransaction(id : String; timestamp : TimeStamp; account_id : String; type : String; operation : String; amount : Decimal; k_symbol : String; otherBank : String; otherAccount : String) : Transaction	;

vars
	transaction : Transaction;
begin
	transaction := create Transaction(id, timestamp, account_id, type,operation, amount, k_symbol, otherBank, otherAccount, self, getAccountById(account_id));
	return transaction;
end;
}
getAccountById
{
getAccountById(id : String) : Account;
begin
	return allAccounts[id];
end;
}
getDistrictById
{
getDistrictById(id : Integer) : District;
begin
	return allDistricts[id];
end;
}
updateAccounts
{
updateAccounts(doAbort : Boolean);
vars
	account : Account;
	count : Integer;
begin
	foreach account in self.allAccounts do
		account.active := true;
		count := count + 1;
		if doAbort and count < 500 then 
			process.setObjectCachePriority(account, 0);
		endif;
		if doAbort and count = 500 then
			abortTransaction;
			beginTransaction;
		elseif count mod 500 = 0 then
			commitTransaction;
			beginTransaction;
		endif;		
	endforeach;
end;
}
updateCustomerSlobs
{
updateCustomerSlobs();
vars
	customer : Customer;
	count : Integer;
begin
	foreach customer in self.allCustomers do
		customer.address_1 &= ">";
		customer.address_2 &= "#";
		count := count + 1;
		if count mod 500 = 0 then
			commitTransaction;
			beginTransaction;
		endif;		
	endforeach;
end;
}
updateCustomers
{
updateCustomers(doAbort : Boolean);
vars
	customer : Customer;
	count : Integer;
begin
	foreach customer in self.allCustomers do
		customer.active := true;
		customer.address_1 := customer.address_1 & "#";
		customer.address_2 := customer.address_2 & "$";
		count := count + 1;
		if doAbort and count < 500 then 
			process.setObjectCachePriority(customer, 0);
		endif;
		if doAbort and count = 500 then
			abortTransaction;
			beginTransaction;
		elseif count mod 500 = 0 then
			commitTransaction;
			beginTransaction;
		endif;		
	endforeach;
end;
}
updateFirstCustomer
{
updateFirstCustomer();
vars
	customer : Customer;
	count : Integer;
	s : String;
begin
	foreach customer in self.allCustomers do
		customer.address_1 := customer.address_1 & CrLf & customer.address_1;
		break;
	endforeach;
end;
}
	)
	Account (
	jadeMethodSources
create
{
create(id : String; district_id : Integer; frequency : String; date : Date; parent : Bank; district : District) updating;
begin
	self.id := id;
	self.district_id := district_id;
	self.frequency := frequency;
	self.date := date;
	self.myDistrict := district;
	self.myBank := parent;
end;
}
	)
	Customer (
	jadeMethodSources
create
{
create(id : String; gender: String; social : String; firstName: String; middleName : String; lastName : String; phone: String;  email: String; address_1 : String; address_2 : String; city : String; state : String; zipcode : String; district_id: Integer;  date : Date; parent : Bank; district : District) updating;

vars

begin
	self.id := id;
	self.gender := gender;
	self.ssn := social;
	self.firstName := firstName;
	self.middleName := middleName;
	self.lastName := lastName;
	self.phoneNumber := phone;
	self.email := email;
	self.address_1 := address_1;
	self.address_2 := address_2;
	self.city := city;
	self.state := state;
	self.zipCode := zipcode;
	self.district_id := district_id;
	self.dateOfBirth := date;
	self.myDistrict := district;
	self.myBank := parent;
end;
}
	)
	District (
	jadeMethodSources
create
{
create(id : Integer; city : String; stateName : String; stateAbbrev : String; region : String; division : String; parent : Bank) updating;

vars

begin
	self.id := id;
	self.city := city;
	self.stateName := stateName;
	self.stateAbbrev := stateAbbrev;
	self.region := region;
	self.division := division;
	self.myBank := parent;
end;
}
	)
	Transaction (
	jadeMethodSources
create
{
create(id : String; timestamp : TimeStamp; account_id : String; type : String; operation : String; amount : Decimal; k_symbol : String; otherBank : String; otherAccount : String; parent : Bank; account : Account) updating;

vars

begin
	self.id := id;
	self.timestamp := timestamp;
	self.account_id := account_id;
	self.type := type;
	self.operation := operation;
	self.amount := amount;
	self.k_symbol := k_symbol;
	self.otherBank := otherBank;
	self.otherAccount := otherAccount;
	self.myBank := parent;
	self.myAccount := account;
end;
}
	)
	DataLoader (
	jadeMethodSources
closeJournal
{
closeJournal() protected;

vars
	dba : JadeDatabaseAdmin;
begin
	create dba transient;
	dba.closeCurrentJournal();
epilog
	delete dba;
end;
}
convertToTimeStamp
{
convertToTimeStamp(string : String) : TimeStamp protected;

vars
	timeStamp : TimeStamp;
	index : Integer;
	timeString : String;
begin
	// 2013-05-03T12:60:53  // some of the test data contains 60 second minutes and seconds, fix that up here by changing it to 60
	
	index := 1;
	
	timeStamp.setDate(string.scanUntil("T", index).Date);
	
	timeString := string[index+1:end];
	
	
	//12:60:53
	if timeString[4:2].Integer >= 60 then
		timeString[4] := '5'.Character;
		timeString[5] := '9'.Character;
	endif;
	
	//12:55:60
	if timeString[7:2].Integer >= 60 then
		timeString[7] := '5'.Character;
		timeString[8] := '9'.Character;
	endif;
		
	timeStamp.setTime(timeString.Time);
	
	return timeStamp;	
end;
}
create
{
create() updating;

vars

begin
	myRoot := Bank.firstInstance();
end;
}
getElapsedTimeString
{
getElapsedTimeString(startClock : Integer) : String typeMethod;
vars
	elapsedTime : Integer;

begin
	elapsedTime := (app.clock - startClock) div 1000;
	if elapsedTime < 1 then
		return "less than 1 second";
	endif;
	return elapsedTime.String & " seconds";
end;
}
handlException
{
handlException(e : Exception; currentRecord : String) : Integer protected;

vars

begin
	if e.errorCode = 1310 then
		write "** duplicated key error ** - " & e.errorObject.String;
		write "are you loading the same data set again?";
	else
		write "** error: (" & e.errorCode.String & ") - " &  e.text() & ", current record: " & currentRecord;
	endif;
	
	return Ex_Abort_Action;
end;
}
loadAccount
{
loadAccount(attributes : JadeRegexResult) protected;
vars
	account_id		: String;
	district_id		: Integer;
	frequency		: String;
	date			: Date;

begin
	if attributes.numMatches < 4 then
		NormalException.raise_(JErr_Regex_Failed_User, method.name);
	endif;

	account_id := attributes.at(1).value;
	district_id := attributes.at(2).value.Integer;
	frequency := attributes.at(3).value;
	date   := attributes.at(4).value.Date;

	self.myRoot.createAccount(account_id, district_id, frequency, date);
end;
}
loadCustomer
{
loadCustomer(attributes : JadeRegexResult) protected;
vars
	id : String; 
	gender: String; 
	social : String; 
	firstName: String; 
	middleName : String; 
	lastName : String; 
	phone: String;  
	email: String; 
	address_1 : String; 
	address_2 : String; 
	city : String; 
	state : String; 
	zipcode : String; 
	district_id: Integer;  
	date : Date;
begin
	if attributes.numMatches < 20 then
		//write 'numMatches = ' & attributes.numMatches.String;		
		//attributes.inspectModal;		
		NormalException.raise_(JErr_Regex_Failed_User, method.name);
	endif;

	id := attributes.at(1).value;
	gender := attributes.at(2).value.String;
	social := attributes.at(8).value;
	firstName := attributes.at(9).value.String;	
	middleName := attributes.at(10).value.String;	
	lastName := attributes.at(11).value.String;	
	phone := attributes.at(12).value.String;	
	email := attributes.at(13).value.String;	
	address_1 := attributes.at(14).value.String;	
	address_2 := attributes.at(15).value.String;	
	city := attributes.at(16).value.String;	
	state := attributes.at(17).value.String;	
	zipcode := attributes.at(18).value.String;	
	district_id := attributes.at(19).value.Integer;	
	date := attributes.at(20).value.Date;

	self.myRoot.createCustomer(id, gender, social, firstName, middleName, lastName, phone, email, address_1, address_2, city, state, zipcode, district_id, date);
end;
}
loadData
{
loadData(directoryPath : String)  updating;
constants
	AccountFileName : String = "account.csv";
	ClientFileName : String = "client.csv";
	DistrictFileName : String = "district.csv";
	TransactionFileName : String = "transaction.csv";

vars
	startTime             : Integer;
	closeTendersStartTime : Integer;
	total                 : Integer;
	currentDate           : Date; 		// Initialized to the current date

begin
	// Get the initial time
	startTime := app.clock;

	// Ensure the supplied directory path is valid
	self.dataDirectory := self.validateDirectoryPath(directoryPath);

	if self.myRoot = null then
		makeBank("Union Bank");
	else
		write "** Warning ** found existing bank: " & self.myRoot.getPropertyValue('name').String & " - " & self.myRoot.String;
	endif;
	
	
	// Load data sets
	self.loadRecords(DistrictFileName, DataLoader::loadDistrict, 100);
	self.loadRecords(AccountFileName, DataLoader::loadAccount, 1000);
	self.loadRecords(ClientFileName, DataLoader::loadCustomer, 200);
	self.loadRecords(TransactionFileName, DataLoader::loadTransaction, 5000);

	write "Data loaded in " & getElapsedTimeString(startTime);
end;
}
loadDistrict
{
loadDistrict(attributes : JadeRegexResult) protected;
vars
	id : Integer;
	city : String;
	stateName : String;
	stateAbbrev : String;
	region : String;
	division : String;
begin
	if attributes.numMatches < 6 then
		NormalException.raise_(JErr_Regex_Failed_User, method.name);
	endif;
	
	id := attributes.at(1).value.Integer;
	city := attributes.at(2).value.String;
	stateName := attributes.at(3).value.String;
	stateAbbrev := attributes.at(4).value.String;
	region := attributes.at(5).value.String;
	division := attributes.at(6).value.String;

	self.myRoot.createDistrict(id, city, stateName, stateAbbrev, region, division);
end;
}
loadRecords
{
loadRecords(fileName : String; loadRecordMethod : JadeMethod; commitModulus : Integer) protected;
vars
	pattern	: JadeRegexPattern;
    splits : JadeRegexResult;
	inputFile : File;
	record : String;
	startClock : Integer;
	count : Integer;
begin

	create pattern;
	pattern.setIgnoreEmptyMatches(false);
	pattern.compile(',');
	
	startClock := app.clock;

	create inputFile transient;	
	inputFile.allowCreate := false;
	inputFile.allowReplace := false;
	inputFile.kind := File.Kind_Unknown_Text;
	inputFile.mode := File.Mode_Input;
	inputFile.fileName := self.dataDirectory & fileName;
	if not inputFile.isAvailable() then
		app.logMessage(method.qualifiedName &  "** error: " & inputFile.fileName & " not found");
		return;
	endif;

	on Exception do handlException(exception, record);
	
	app.logMessage(method.qualifiedName &  "Loading " & inputFile.fileName & "...");
	
	beginTransaction;
	// read and ignore header
	record := inputFile.readLine.trimBlanks;
	while not inputFile.endOfFile do
		record := inputFile.readLine.trimBlanks;
		// Empty lines  are skipped
		if record <> null then
			pattern.split(record, splits);
			invokeMethod(appContext, loadRecordMethod, splits);
		endif;
		count := count + 1;
		if count mod commitModulus = 0 then
			commitTransaction;
			beginTransaction;
		endif;
						
	endwhile;
	commitTransaction;

	app.logMessage(method.qualifiedName & ' ' &  count.String & " records loaded in " & getElapsedTimeString(startClock));

epilog
	delete pattern;
	delete inputFile;
end;
}
loadTransaction
{
loadTransaction(attributes : JadeRegexResult) protected;
vars
	id : String; 
	timestamp : TimeStamp; 
	account_id : String; 
	type : String; 
	operation : String; 
	amount : Decimal[15,2]; 
	k_symbol : String; 
	otherBank : String; 
	otherAccount : String; 

begin
	if attributes.numMatches < 9 then
		NormalException.raise_(JErr_Regex_Failed_User, method.name);
	endif;

	account_id := attributes.at(1).value;
	timestamp := convertToTimeStamp(attributes.at(2).value);
	id := attributes.at(3).value;
	type := attributes.at(4).value;
	operation := attributes.at(5).value;
	amount := attributes.at(6).value.Decimal;
	k_symbol := attributes.at(7).value;
	otherBank := attributes.at(8).value;
	otherAccount := attributes.at(9).value;
	
	self.myRoot.createTransaction(id, timestamp, account_id, type,operation, amount, k_symbol, otherBank, otherAccount);
end;
}
makeBank
{
makeBank(name : String) updating, protected;

vars

begin
	beginTransaction;
	// Create our singleton persistent Bank
	self.myRoot := create Bank(name) persistent;
	commitTransaction;
end;
}
validateDirectoryPath
{
validateDirectoryPath(directoryPath : String) : String protected;
// --------------------------------------------------------------------------------
// Method:		zValidateDirectoryPath
//
// Purpose:		Validates a directory path. Raises an InvalidDirectoryPath
//              ModelException if the path is not valid.
//
// Returns:     The directory path with a "/" suffix
// --------------------------------------------------------------------------------
vars
	returnDirPath : String;
	dir           : FileFolder;

begin
	returnDirPath := directoryPath.trimBlanks;

	if returnDirPath.length <= 0 then
		app.raiseModelException(InvalidDirectoryPath);
		return null;
	endif;

	if returnDirPath[returnDirPath.length] <> "/" and returnDirPath[returnDirPath.length] <> "\" then
		returnDirPath := returnDirPath & "/";
	endif;

	create dir transient;

	if not dir.isValidPathName(returnDirPath) then
		app.raiseModelException(InvalidDirectoryPath);
		return null;
	endif;

	dir.fileName := returnDirPath;
	if not dir.isAvailable then
		app.raiseModelException(InvalidDirectoryPath);
		return null;
	endif;

	return returnDirPath;

epilog
	delete dir; // does nothing if dir is null
end;
}
	)
	JadeScript (
	jadeMethodSources
closeJournal
{
closeJournal();

vars
	dba : JadeDatabaseAdmin;
begin
	create dba transient;
	dba.closeCurrentJournal();
	write dba.getCurrentJournalName();
epilog
	delete dba;
end;
}
generateDesc
{
generateDesc();

vars
	jaa : JadeAuditAccess;
begin

	create jaa transient;
	
	beginTransaction;
		jaa.generateDescription();
	commitTransaction;

end;
}
getCurrentJournalOffset
{
getCurrentJournalOffset(currentJournal: Integer64 output; currentOffset : Integer64 output);
vars
	unused : Integer64;
	dba : JadeDatabaseAdmin;
begin
	create dba transient;
	dba.getCurrentJournalOffset(currentJournal, currentOffset, unused, unused, unused);
epilog
	delete dba;
end;
}
loadData
{
loadData();

vars
	dataLoader : DataLoader;
	fileFolder : FileFolder;
	dirPath    : String;

begin
	// Ask for the directory containing the initial data files
	create fileFolder transient;
	//dirPath := fileFolder.browseForFolder("Select data file directory", app.dbPath);
	dirPath := "\schemas\Jade\DataFiles";
	if dirPath <> null then
		// Create our data loader and initialize the database
		create dataLoader transient;
		dataLoader.loadData(dirPath);
	endif;
	
epilog
	delete dataLoader; // does nothing if dataLoader is null
	delete fileFolder; // does nothing if fileFolder is null
end;
}
purgeCustomers
{
purgeCustomers();

vars
	bank : Bank;
begin
	bank := Bank.firstInstance;
	beginTransaction;
	bank.allCustomers.purge();
	commitTransaction;

end;
}
purgeData
{
purgeData();

vars

begin
	beginTransaction;
	delete Bank.firstInstance;
	commitTransaction;

end;
}
purgeTransactions
{
purgeTransactions();

vars
	bank : Bank;
	transaction : Transaction;
	startClock : Integer;
	count : Integer;
begin
	bank := Bank.lastInstance();
	startClock := app.clock();
	beginTransaction;
	foreach transaction in bank.allTransactions do
		count += 1;
		if count mod 50000 = 0 then
			commitTransaction;
			beginTransaction;
			write count.String & " transactions deleted in " & DataLoader@getElapsedTimeString(startClock);
		endif;
		delete transaction;
	endforeach;
	commitTransaction;

end;
}
setCaptureState
{
setCaptureState();

vars
	jda : JadeDatabaseAdmin;
	journal,offset : Integer64;
begin
	create jda transient;

	jda.closeCurrentJournal();
	
	journal := jda.getCurrentJournalNumber;
	
	system.setJournalChangeCaptureState(journal, offset);
end;
}
startCapture
{
startCapture() serverExecution;

begin
	system.startJournalChangeCapture();
end;
}
startCaptureAtCurrent
{
startCaptureAtCurrent();

vars
	currentJournal: Integer64;
	currentOffset : Integer64;
begin
	getCurrentJournalOffset(currentJournal, currentOffset);
	system.setJournalChangeCaptureState(currentJournal, currentOffset);	
end;
}
stopCapture
{
stopCapture() serverExecution;

vars

begin
	system.stopJournalChangeCapture();
end;
}
updateAccounts
{
updateAccounts();

vars
	bank : Bank;
begin
	bank := Bank.firstInstance();
	beginTransaction;
	bank.updateAccounts(false);
	commitTransaction;
end;
}
updateCustomerSlobs
{
updateCustomerSlobs();

vars
	bank : Bank;
begin
	bank := Bank.firstInstance();
	beginTransaction;
	bank.updateCustomerSlobs();
	commitTransaction;
end;
}
updateCustomers
{
updateCustomers();

vars
	bank : Bank;
begin
	bank := Bank.firstInstance();
	beginTransaction;
	bank.updateCustomers(false);
	commitTransaction;
end;
}
updateFirstCustomer
{
updateFirstCustomer();

vars
	bank : Bank;
begin
	bank := Bank.firstInstance();

	beginTransaction;
	bank.updateFirstCustomer;
	commitTransaction;
end;
}
	)
	Binary (
	jadeMethodSources
init
{
init(length : Integer) updating;

vars
	str, str2 : Binary;
	i : Integer;
	j : Integer;
begin
	if length = 0 then
		self := null;
	else
		str[ length : 1 ] := null;
		str := null;
		foreach i in 1 to 255 do	
			if i < 64 or i > 127 then
				j := 65;
			else
				j := i;
			endif;
		
			str[ i + 1 ] := j.Byte;
		endforeach;
		foreach i in 1 to length step str.length do
			str2 := str2 & str;
		endforeach;
		self := str2[ 1 : length ];
	endif;	
end;
}
update
{
update(length : Integer) updating;

vars
	str, str2 : Binary;
	i,j : Integer;
begin
	if length = 0 then
		self := null;
	else
		str[ length : 1 ] := null;
		str := null;
		foreach i in 0 to 255 do
			j := (255 - i);
			
			if j < 64 or j > 127 then
				j := 66;			
			endif;
			
			str[ i + 1 ] := j.Byte;
		endforeach;
		foreach i in 1 to length step str.length do
			str2 := str2 & str;
		endforeach;
		self := str2[ 1 : length ];
	endif;	
end;
}
	)
	Date (
	jadeMethodSources
convertDate
{
convertDate() : String;
 
vars
 
begin
	if not self.isValid() then
		return null;
	endif;
	return self.format("yyyy-MM-dd");
end;
}
	)
	String (
	jadeMethodSources
endsWith
{
endsWith(token:String):Boolean;

begin
	return token.length > 0 and self.length >= token.length and self[self.length - token.length + 1:token.length] = token;
end;
}
init
{
init(length : Integer) updating;

vars
	str, str2 : String;
	i : Integer;
	j : Integer;
begin
	if length = 0 then
		self := "";
	else
		str := 'ABCDEFGHIJKLMNOPQRSTUVWXTZ1234567890abcdefghijklmnopqrstuvwxyz'.reverse;
		foreach i in 1 to length step str.length do
			str2 := str2 & str;
		endforeach;
		self := str2[ 1 : length ];
	endif;	
end;
}
update
{
update(length : Integer) updating;

vars
	str, str2 : String;
	i,j : Integer;
begin
	if length = 0 then
		self := "";
	else
		str := 'ABCDEFGHIJKLMNOPQRSTUVWXTZ1234567890abcdefghijklmnopqrstuvwxyz';
		foreach i in 1 to length step str.length do
			str2 := str2 & str;
		endforeach;
		self := str2[ 1 : length ];
	endif;	
end;
}
	)
	StringUtf8 (
	jadeMethodSources
init
{
init(length : Integer) updating;

vars
	str, str2 : StringUtf8;
	i : Integer;
	j : Integer;
begin
	if length = 0 then
		self := "";
	else
		str := 'ABCDEFGHIJKLMNOPQRSTUVWXTZ1234567890abcdefghijklmnopqrstuvwxyz'.StringUtf8;
		foreach i in 1 to length step str.length do
			str2 := str2 & str;
		endforeach;
		self := str2[ 1 : length ];
	endif;	
end;
}
update
{
update(length : Integer) updating;

vars
	str, str2 : StringUtf8;
	i,j : Integer;
begin
	if length = 0 then
		self := "";
	else
		str := 'ABCDEFGHIJKLMNOPQRSTUVWXTZ1234567890abcdefghijklmnopqrstuvwxyz'.reverse.StringUtf8;		
		foreach i in 1 to length step str.length do
			str2 := str2 & str;
		endforeach;
		self := str2[ 1 : length ];
	endif;	
end;
}
	)
	TimeStamp (
	jadeMethodSources
convertTimeStamp
{
convertTimeStamp() : String;
 
vars
	ts1 : TimeStamp;
begin
	ts1 := self;

	if not ts1.date.isValid() then
		return null;
	endif;
	return ts1.date.format("yyyy-MM-dd") & 'T' & ts1.time.format("HH:mm:ss") & '.' & ts1.time.milliSecond().padLeadingWith("0", 3) & 'Z';
end;
}
logFormat
{
logFormat():String;

vars
	s:String;
begin
	if self.time.milliSecond=0 then  
		s:=".000";
	endif;
	return self.date.format("yyy/MM/dd ")&self.literalFormat[12:end]&s;
end;
}
	)
	TimeStampInterval (
	jadeMethodSources
convert_RFC_Duration
{
convert_RFC_Duration(rfcFormatted : String):Integer64;

constants
	Second : Integer64 = 1000;
	Minute : Integer64 = 60*Second;
	Hour : Integer64 = 60 * Minute;
	Day : Integer64 = 24 * Hour;
	Week : Integer64 = 7 * Day;
vars
	json : String;
	jj : JadeJson;
	i,j,k : Integer;
	milli : String;
	seconds : String;
	minutes : String;
	hours : String;
	days : String;
	weeks : String;
	tsi : TimeStampInterval;
	result : Integer64;
begin

	json := rfcFormatted;
	
	i := json.pos('P',1);	
	j := json.pos('W',1);		
	weeks := json[i+1:j-i-1];
	//write weeks;	
	
	
	i := json.pos('W',1);	
	j := json.pos('D',1);		
	days := json[i+1:j-i-1];
	//write days;
	
	
	i := json.pos('T',1);	
	j := json.pos('H',1);		
	hours := json[i+1:j-i-1];
	//write hours;
	
	
	i := json.pos('H',1);
	j := json.pos('M',i);
	minutes := json[i+1:j-i-1];
	//write minutes;
	
	
	
	i := json.pos('M',1);
	j := json.pos('.',i);
	seconds := json[i+1:j-i-1];
	//write seconds;
	
	
	i := json.pos('.',1);
	j := json.pos('S',i);
	milli := json[i+1:j-i-1];
	//write milli;

	
	result := weeks.Integer64*Week + days.Integer64*Day + hours.Integer64*Hour + minutes.Integer64*Minute + seconds.Integer64*Second + milli.Integer64;
	
	return result;
	
end;
}
setForTest
{
setForTest(setSelf : Boolean):Integer64 updating;

vars
    time     : Time;
    date     : Date;
    ts1, ts2 : TimeStamp;
    interval : TimeStampInterval;
	result : Integer64;
begin
    date.setDate(31,10,2023);       
    time.setTime(12,30,10,10);      
    ts1.setDate(date);
    ts1.setTime(time);
    date.setDate(31,10,2024);         
    time.setTime(14,23,31,444);       
    ts2.setDate(date);
    ts2.setTime(time);
    interval := ts2 - ts1;
	
	if setSelf then
		self := interval;
    endif;
	
	result := interval.getMilliseconds;	// 31629201434
	
	return result;	
end;
}
	)
