MVC Programming Exercise
========================

This programming exercise is a real-world example of iOS client development work we have done. We use it to judge the following skills:

1. Basic technical proficiency
2. Code structure and programming style (including quality and maintenance mindsets)
3. Problem decomposition and interaction with co-workers

This exercise has its challenges but there are no hidden tricks. We have endeavored to give you the information you need to complete the assignment, but it is natural to have questions. You should feel free to ask whenever you need clarification, or even if you are stuck. Part of our evaluation of item #3 above has to do with when and how you reach out; in the end, it is better to ask and deliver a good solution than to remain quiet and miss the mark.

Context
-------

We are developing a new feature that will help customers safeguard their identities and take remedial measures in the case of identity theft. One aspect of the service is the ability to monitor a digital persona. If our services find hints online that personal information has been leaked or is being sold, we will send alerts to customers with details on what we have found and what they can do to fix the problem.

As in much iOS development, heavy use of the Model-View-Controller (MVC) design pattern. In this exercise, you will be implementing an MVC structure for one type of alert: a leaked email address.

The product manager has written the following story to describe the business requirements.

User Story
----------

*Title*:  should display full email alert detail

*Description*: As an iOS Personal customer, I need to be able to see the full email alert detail so that I can know how my email has been compromised and what corrective actions I can take.

*Acceptance Criteria*: 

1. The navigation bar has a title which describes the alert
2. Below the navigation bar there is an alert header. The header consists of:
	a. An icon specific to the type of alert (CyberAgent)
	b. A header specific to the type of alert (CyberAgent)
	c. A sub header specific to the type of alert (CyberAgent)
3. Below the header appear one or more leaked details. Each detail consists of:
	a. An icon specific to the type of matched information (Email)
	b. The leaked information
	c. The source of the leak
	d. The date of the leak
4. There should be a "What's at risk" section with the Email-specific risk description.
5. There should be a "Next steps" section with the three Email-specific remediation recommendations.
6. There should be a "Need help?" section with a "Contact us now" button to contact our help line. When a user taps on this button, the app should display a popup alert:
	a. Title: "Contact us"
	b. Message: "Call our experts for help."
	c. Buttons: "Cancel" and "Call". Tapping either button closes the alert.
7. There should be a "Remind me later" button. When a user taps on this button, the app should display a popup alert:
	a. Title: "Reminder scheduled"
	b. Message: "We’ll remind you about this alert tomorrow."
	c. Button: "OK". Tapping this button closes the alert.
8. There should be a "Mark as resolved" button. When a user taps on this button, the app should display a popup alert:
	a. Title: "Are you sure?"
	b. Message: "Marking an alert as resolved means you will no longer be alerted on this leak and the alert will be removed."
	c. Buttons: "Cancel" and "Yes". Tapping on either button closes the alert.

See "ux.png" for the user experience design.

Technical Requirements
----------------------

In addition to meeting all of product acceptance criteria above, your solution should meet the following technical requirements:

1. You should deliver a simple app that can run and display an email alert using the provided "email-alert.json" file as mock data.
2. You can write your code in Objective-C or Swift - your choice.
3. Your app should run against either iOS 9 or 10 (your choice, but you should let us know whether we need to open in Xcode 7 or 8)
4. Your app should run in portrait mode on iOS devices with screen sizes as small as an iPhone SE all the way up to an iPad Pro.

Implementation Notes
--------------------

There are 3 types of alerts: 
- "CyberAgent" alerts which provide information on personal data found for sale on black market sites or in dumps from data breaches
- "SocialMedia" alerts which provide information from linked social network accounts such as Twitter and Facebook
- "SSNTrace" alerts which provide information on data associated with a particular Social Security number

Alerts are read-only data, so values never need to change. 

The Email alert you are dealing with in this exercise is a "CyberAgent" alert.

All of the alert types have a common data structure, which you can see in the "alert-schema.json" file. Specifically, each alert is a JSON object which consists of:

1. An "id" which uniquely identifies the alert
2. A "type" which identifies the alert type (1=CyberAgent, 2=SSNTrace, 3=SocialMedia)
3. An array of "events" which contain information about the alert

In turn, each "event" is a JSON object which consists of:

1. A "date" in the format of YYYY-MM-DD which identifies the date when the information was found
2. A "data" JSON object which has key-value pairs that are specific to each alert type (i.e., CyberAgent key-value pairs are different than SSNTrace key-value pairs or SocialMedia key-value pairs)

In the user interface, all three alert types will need to display the following:

1. Alert title based on the alert type and details.
2. Icon based on the alert type
3. Header text based on the alert type
4. Subheader text based on the alert type
5. One or more alert details (the "events" array) - display depends on alert type
6. One or more risk factors (the "What's at risk" section) - depends on alert details
7. One or more remediation suggestions (the "Next steps" section) - depends on alert details

A good solution will consider how to handle all three types of alerts (though you can simply stub out the types that we aren't handling in this exercise). 

For CyberAgent alerts, the data section may have these key-value pairs:

1. "SourceDate" is a date in the format "YYYY-MM-DD" when the information was originally leaked. If this value is present, this is the value that should be displayed in the alert.
2. "CreationDate" is an ISO8601-format date for the time when the information was found. If there is no "SourceDate" then this date may be displayed in the alert.
3. "site" is the website where the leaked information was found. If this information is present, it should be displayed as the origin of the leak.
4. "Source" is the location where the leaked information was found. If there is no "site" then this value may be displayed as the origin of the leak.
5. "match" is the type of data found/leaked. The following are valid match types:
	a. IDSSN - a social security number
	b. IDDLNUMBER - a driver's license number
	c. IDMEDICALID - a medical insurance ID
	d. IDHOMEPHONE - a home phone number
	e. IDWORKPHONE - a work phone number
	f. IDCELLPHONE - a cell phone number
	g. IDEMAILADDR - an email address
	h. IDCCN - a credit card number
	i. IDBANK - a bank account number
	j. IDNATIONAL - a national ID number
	k. IDIBAN - an IBAN number
	l. IDPASSPORTNUM - a passport number
	m. IDRETAILCARD - a retail card number
6. Depending on the value in the match field, there may be one or more other data fields present which contain the actual matched values. Since we are only implementing Email alerts for this exercise, you only need to care about the "email" node, which will have the value of the email found.

A good solution will consider how to handle different match types (though you can stub out the types we aren't handling in this exercise). 

The display logic for CyberAgent alerts is as follows:

1. The alert title depends on the events and their match type. If there is one event and the match type is email then the title is "Email Address Leaked".
2. The alert type icon is the image file "ic-cyberagent-alert.png"
3. The header title is always "Identity Risk"
4. The header subtitle depends on events and their match type. In the case of a single event with a match type of email, the subtitle is "Your email has been leaked"
5. Each alert detail should display:
	a. An icon based on the type. In the case of email, the icon is the image file, "ic-email-alert.png"
	b. The leaked information (i.e., the email address)
	c. The origin of the leak, prefixed by the word "From:"
	d. The date of the leak, prefixed by the phrase: "Date of leak:"
6. The "What's at risk" section when there is one event and a match type of email will have 1 suggestion: "Your email and password were compromised and could be used to access other accounts."
7. The "Next steps" section when there is one event and the match type is email will have 3 suggestions:
	a. "Change your password immediately" with the icon image file "ic-ellipsis-step.png"
	b. "Change passwords for any accounts that share this email and password combo" with the icon image file "ic-email-step.png"
	c. "Keep an eye on accounts for any strange behavior" with the icon image file "ic-strangebehavior-step.png"

You are welcome to use the RoundedRectButton class for the two buttons at the bottom of the screen. The implementation for this class and its dependency are available in the "source" folder.

Bonus points for writing unit tests.

User Experience Notes
---------------------

All text is either AvenirNext-Regular or AvenirNext-DemiBold, 14 point
The red color on the screen is red 208, green 0, blue 27, alpha 100
The headlines and bold text on the screen are a dark gray (30% white)
The non-bold text on the screen is a medium gray (50% white)
The "Contact us now" green is red 61, green 178, blue 73, alpha 100
The "Remind me later" foreground green is the same as the "Contact us now" green. The shadow color is red 12, green 133, blue 63, alpha 100
The "Mark as resolved" foreground color is a dark gray (40% white). The shadow color is true black (0% white).
The two buttons at the bottom of the screen have a corner radius of 5 and a shadow offset of 3. They each have a height of 44 pixels. They should be equal widths and fill the width of the screen except for margin to the left or right and margin between them. 
Most margins on the screen are 16 pixels. The narrower margins are 8 pixels.
When it is necessary to overflow, text should wrap by word. The screen should scroll if needed, but scrolling should be limited to the vertical direction. The two buttons at the bottom of the screen and the navigation bar with the title at the top are pinned and should not scroll, but everything in between (red alert header to Need help? section) should scroll.