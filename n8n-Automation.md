# Masterclass 1: Building an Admissions Automation Workflow with n8n

# Hands-on Lab

# Lab Overview

In this hands-on lab, you will build an end-to-end admissions automation workflow using **n8n**.

The workflow simulates how **Zindua School** processes student applications submitted through its online admission form. Instead of manually recording applications, routing them to the correct admissions team, and sending confirmation emails, we will automate the entire admissions process.

By the end of this lab, you will have built a workflow that:

- Captures student applications submitted through an online admission form.
- Cleans and standardizes applicant data.
- Validates required fields.
- Stores applications in Google Sheets.
- Prevents duplicate applications.
- Routes applications to the appropriate admissions team.
- Sends an acknowledgment email to the applicant.
- Sends an internal notification to the admissions team.

---

# Business Use Case

Every day, prospective students apply to join **Zindua School** by completing an online admission form.

The admission form collects important information including:

- First Name
- Last Name
- Phone Number
- Email Address
- Preferred Program

Currently, processing these applications involves several manual steps.

This creates several challenges:

- Admissions officers manually record applications in spreadsheets.
- Duplicate applications from the same applicant create duplicate records.
- Applications must be manually assigned to the correct admissions team based on the selected program.
- Applicants may wait several hours before receiving confirmation that their application has been received.
- Admissions officers may forget to follow up with applicants.

Our objective is to automate this admissions process using **n8n**.

Whenever an applicant submits the admission form, the workflow should:

1. Capture the submitted application.
2. Clean and standardize the applicant's information.
3. Validate that all required fields have been completed.
4. Store new applications or update existing applicant records in Google Sheets.
5. Determine which admissions department should process the application.
6. Notify the appropriate admissions team.
7. Send an acknowledgment email confirming that the application has been received.

---

# Learning Objectives

By the end of this lab, you should be able to:

- Build workflows using n8n.
- Create online forms using the Form Trigger node.
- Transform data using Edit Fields (Set).
- Validate submitted data using IF nodes.
- Integrate Google Sheets with n8n.
- Prevent duplicate applications.
- Route applications using Switch nodes.
- Send automated emails using Gmail.
- Build a real-world admissions automation workflow.

---

# Workflow Architecture

```text
Applicant
    │
    ▼
Admission Form
(Form Trigger)
    │
    ▼
Clean Applicant Data
    │
    ▼
Validate Application
    │
    ▼
Google Sheets
(Append or Update Row)
    │
    ▼
Assign Department
    │
    ▼
Switch
 ┌──────────┴──────────┐
 ▼                     ▼
Data Programs   Software Engineering Programs
 │                     │
 ▼                     ▼
Notify Admissions Notify Admissions
 │                     │
 ▼                     ▼
Applicant        Applicant
Confirmation     Confirmation
Email            Email
```

---

# Part 1: Prepare the Resources

Before building the workflow, let's prepare the resources that our automation will use.

---

## Step 1: Create the Google Sheet

Create a new Google Sheets spreadsheet called:

```text
Zindua Applications
```

Rename the first worksheet to:

```text
Applications
```

Create the following columns:

| Application ID | First Name | Last Name | Email | Phone | Program | Department | Submitted At | Status |
| -------------- | ---------- | --------- | ----- | ----- | ------- | ---------- | ------------ | ------ |

The **Status** column should initially contain the value **New** for every application.

---

# Part 2: Build the Workflow

In this section, we'll build the structure of the admissions automation workflow. We'll leave the Google Sheets and Gmail nodes unconfigured for now and connect them after setting up our Google credentials.

---

## Step 1: Create the Admission Form

Create a **Form Trigger** node.

Rename the node:

```text
Admission Form
```

Configure the following fields:

| Field             | Type     |
| ----------------- | -------- |
| First Name        | Text     |
| Last Name         | Text     |
| Phone Number      | Number   |
| Email Address     | Email    |
| Preferred Program | Dropdown |

Example programs:

- Data Science
- Data Analytics
- Data Engineering
- AI Engineering
- Software Engineering
- Frontend Development
- Backend Development
- Full Stack Development

Submit the form once to verify that it triggers the workflow.

---

## Step 2: Clean Applicant Data

Add an **Edit Fields (Set)** node.

Rename it:

```text
Clean Applicant Data
```

Map the fields as follows:

| New Field    | Original Field         |
| ------------ | ---------------------- |
| First Name   | First Name             |
| Last Name    | Last Name              |
| Full Name    | First Name + Last Name |
| Email        | Email Address          |
| Phone        | Phone Number           |
| Program      | Preferred Program      |
| Submitted At | submittedAt            |

---

## Step 3: Add the Google Sheets Node

Add a **Google Sheets** node.

Operation:

```text
Append or Update Row
```

> **Note:** Don't configure this node yet. We'll connect it to Google Sheets after setting up our credentials.

---

## Step 4: Assign Department

Add another **Edit Fields (Set)** node.

Rename it:

```text
Assign Department
```

Create a new field named:

```text
department
```

Use the following expression:

```javascript
{
  {
    [
      "Data Science",
      "Data Analytics",
      "Data Engineering",
      "AI Engineering",
    ].includes($json["Program"])
      ? "Data"
      : "Software Engineering";
  }
}
```

---

## Step 5: Route the Application

Add a **Switch** node.

Mode:

```text
Rules
```

### Rule 1

Value 1

```javascript
{
  {
    $json.department;
  }
}
```

Operation

```text
is equal to
```

Value 2

```text
Data
```

---

### Rule 2

Value 1

```javascript
{
  {
    $json.department;
  }
}
```

Operation

```text
is equal to
```

Value 2

```text
Software Engineering
```

---

## Step 6: Add the Gmail Nodes

Add three Gmail nodes to the workflow:

- Notify Data Admissions
- Notify Software Admissions
- Applicant Confirmation

> **Note:** Don't configure these Gmail nodes yet. We'll authenticate them after connecting n8n to Google.

---

# Part 3: Connect n8n to Google

Our workflow structure is now complete. Before the Google Sheets and Gmail nodes can communicate with Google services, we need to authorize n8n using Google Cloud OAuth credentials.

---

## Step 1: Create a Google Cloud Project

1. Open the **Google Cloud Console**.
2. Click **Select a Project → New Project**.
3. Name the project:

```text
Zindua n8n Masterclass
```

4. Click **Create**.
5. Ensure the newly created project is selected.

---

## Step 2: Enable the Required APIs

Navigate to:

```text
APIs & Services → Library
```

Enable the following APIs:

- Google Sheets API
- Google Drive API
- Gmail API

These APIs allow n8n to:

- Read and write data in Google Sheets.
- Access spreadsheets stored in Google Drive.
- Send emails using Gmail.

---

## Step 3: Configure the OAuth Consent Screen

Navigate to:

```text
APIs & Services → OAuth Consent Screen
```

Configure the application as follows:

| Setting                 | Value                  |
| ----------------------- | ---------------------- |
| User Type               | External               |
| App Name                | Zindua n8n Masterclass |
| User Support Email      | Your Gmail Address     |
| Developer Contact Email | Your Gmail Address     |

Save the configuration.

---

## Step 4: Add Yourself as a Test User

Navigate to:

```text
OAuth Consent Screen → Audience → Test Users
```

Click **Add Users**.

Add the Gmail account that you'll use to authenticate with n8n.

Click **Save**.

---

## Step 5: Create OAuth Credentials

Navigate to:

```text
APIs & Services → Credentials
```

Click:

```text
Create Credentials
```

Select:

```text
OAuth Client ID
```

Application Type:

```text
Web Application
```

Example name:

```text
n8n OAuth Client
```

---

## Step 6: Configure the Redirect URI

Google needs to know where users should be redirected after successfully authenticating.

### Local Installation

```text
http://localhost:5678/rest/oauth2-credential/callback
```

### Self-Hosted Installation

```text
https://your-domain.com/rest/oauth2-credential/callback
```

> **Tip:** The easiest way to obtain the correct Redirect URI is to start creating the credential inside n8n. Copy the Redirect URI displayed by n8n and paste it into Google Cloud.

Click **Create**.

Copy and save the generated:

- Client ID
- Client Secret

You'll use these values when creating credentials in n8n.

---

# Part 4: Configure Credentials in n8n

Open your n8n instance.

Navigate to:

```text
Credentials
```

---

## Google Sheets OAuth2 Credential

Click:

```text
Create Credential
```

Select:

```text
Google Sheets OAuth2 API
```

Configure the credential:

| Field         | Value                   |
| ------------- | ----------------------- |
| Client ID     | Paste from Google Cloud |
| Client Secret | Paste from Google Cloud |

Leave the remaining settings as their default values.

Click:

```text
Connect My Account
```

Sign in using the Gmail account you added as a Test User.

Grant the requested permissions.

If successful, the credential status will display:

```text
Connected
```

---

## Gmail OAuth2 Credential

Create another credential.

Select:

```text
Gmail OAuth2 API
```

Use the same:

- Client ID
- Client Secret

Click:

```text
Connect My Account
```

Authenticate with the same Google account and grant Gmail permissions.

Once connected, the credential status should display:

```text
Connected
```

> **Note:** You only need one OAuth Client in Google Cloud. The same Client ID and Client Secret can be reused for both Google Sheets and Gmail.

---

## Self-Hosted n8n Configuration

If you're using a self-hosted instance of n8n, verify the following settings.

### Allowed HTTP Request Domains

Set to:

```text
All
```

### Google Sheets Node

For **Custom Specs**, set:

```text
Disabled (Off)
```

---

## Verify Your Credentials

Before returning to the workflow, verify that:

- Google Sheets OAuth2 is connected.
- Gmail OAuth2 is connected.
- Your Google account is accessible from n8n.
- No authentication errors are displayed.

---

# Part 5: Finish Configuring the Workflow

Now that your credentials are connected, return to the workflow and configure the nodes that interact with Google services.

---

## Step 1: Configure the Google Sheets Node

Open the Google Sheets node you added earlier.

Select:

- Your Google Sheets credential
- Spreadsheet: **Zindua Applications**
- Worksheet: **Applications**

Use:

```text
Email
```

as the matching column.

This ensures that duplicate applications update the existing record instead of creating a new one.

---

## Step 2: Configure the Admissions Notification Emails

Configure the **Notify Data Admissions** Gmail node.

Subject:

```text
New Application - {{$json["Program"]}}
```

Body:

```text
A new application has been submitted.

Applicant Details

Name:
{{$json["First Name"]}} {{$json["Last Name"]}}

Email:
{{$json["Email"]}}

Phone:
{{$json["Phone"]}}

Program:
{{$json["Program"]}}

Submitted At:
{{$json["Submitted At"]}}

Please review the application and follow up with the applicant.
```

Duplicate this node for the Software Engineering branch and update the recipient email address.

---

## Step 3: Configure the Applicant Confirmation Email

Rename the Gmail node:

```text
Applicant Confirmation
```

Recipient:

```javascript
{
  {
    $json["Email"];
  }
}
```

Subject:

```text
Application Received – Welcome to Zindua School
```

Body:

```text
Hi {{$json["First Name"]}},

Thank you for submitting your application to Zindua School.

We have successfully received your application for the {{$json["Program"]}} program.

Our admissions team is currently reviewing your application and will contact you shortly with the next steps.

We appreciate your interest in learning with Zindua and look forward to supporting you on your learning journey.

Kind regards,

Zindua School Admissions Team
```

---

# Part 6: Test the Workflow

Submit a sample application using the admission form and verify that:

- The workflow is triggered successfully.
- Applicant information is cleaned and standardized.
- The application is stored in Google Sheets.
- Duplicate submissions update the existing record.
- The application is routed to the correct admissions department.
- The admissions team receives an automated notification email.
- The applicant receives an acknowledgment email confirming that the application has been received.
