A small extension (Codeunit) to Post the Journal entries in Microsoft Business Central via OData API.

# Prerequisites
- Get access to the Sandbox environment (production environment will not work for development/compilation perspective) of Microsoft Business Central
- Install Visual Studio Code

# Setup
- Clone this repository into your local system
- Install MS AL extension in VS code as mentioned here - https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-get-started
- Open the cloned repository folder in the VS code
- Goto `.vscode/launch.json` and update the following fields:
  - `serverInstance`: Environment name of the MS Business Central
  - `tenant`: Tenant GUID of the MS Business Central account _(Tip: You can find the Tenant GUID in the browser's URL when you login to your MS Business Central account)_
  - `environmentType`: Must be `Sandbox` for development purposes
  - `environmentName`: Environment name of the MS Business Central
- Save these changes, and download the AL Symbols from MS Business Central.
  - To download the AL Symbols, a dialog box will pop up automatically in the VS Code, using which you can download the AL Symbols.
  - Alternatively, if that dialog box doesn't appear, just restart the VS Code and that dialog will automatically appear if AL Symbols are not found in your current folder.
    - For the first time, it would ask to authenticate your user using `Microsoft Extranet` and would open the authentication page in the browser, just follow the steps as mentioned in the instructions during this process.

# How to package this Codeunit?
- Once the setup is done, and there are no errors in the project, open `Command Palette` in VS Code, and execute the following command
  - `AL: package`
- By the time if packaging is successful, then `*.app` file will have been generated in the main folder of your project.
- This `*.app` file is the final extension artifact that needs to be deployed on Microsoft Business Central.

# How to install the extension (Codeunit) on Microsoft Business Central?
- Login into your MS Business Central account.
- Search and open `Extension Management` in the global search of Business Central (a search icon in the top bar).
- Click on `Manage > Upload Extension...`
  - ![image](https://github.com/jigneshkhatri/MBC-Gen-Journal-Line-Posting-CodeUnit/assets/8259729/97eb75f4-d4b3-4cb5-929b-a2fffa00971f)
- Select and upload the `*.app` file which is generated in the above steps.
- Track the upload process in the `Manage > Installation Status` menu.
- Once the installation process is `Completed`, then you can see this extension in the `Installed Extensions` card (Extension Management).

# How to create and publish a Web Service for this Codeunit?
- Once the extension is successfully installed, search and open `Web Services` in the global search of Business Central.
- Click on the `+ New` button in the top ribbon.
  - ![image](https://github.com/jigneshkhatri/MBC-Gen-Journal-Line-Posting-CodeUnit/assets/8259729/6b8d5744-2fa4-4777-b233-6f7202c70902)
  - Select `Codeunit` as Object Type
  - Select `50101` as Object ID - _This is the same ID that we have mentioned in the source code while declaring the Codeunit._
  - Write any meaningful name in the Service Name
  - Tick the `Published` checkbox against this new entry to publish this web service.

# How to trigger this Codeunit using OData API? 
- Once the Web Service is published as per the above step, build the OData API URL in the below pattern:
  - `https://api.businesscentral.dynamics.com/v2.0/<tenant id>/<environment name>/ODataV4/<service name>_<procedure name>?company=<company id>`
    - Here the `<service name>` should be the name of the service that we have entered while creating the Web Service in the above step.
    - `<procedure name>` is the name of the procedure that we have created in the Codeunit. In our case, it would be `PostGenJournalLine`.
    - HTTP method: `POST`
- Below is the sample cURL for this API:
  - ```
      curl --location 'https://api.businesscentral.dynamics.com/v2.0/<tenant id>/<environment name>/ODataV4/<service name>_PostGenJournalLine?company=<company id>' \
      --header 'Content-Type: application/json' \
      --header 'Authorization: Bearer <auth token>' \
      --data '{
          "genJournalLineID": "<Journal line item GUID which needs to be posted>"
      }'
    ```

# References:
- https://community.dynamics.com/forums/thread/details/?threadid=aa816d75-a4b0-ee11-a569-002248255405
- https://github.com/microsoft/ALAppExtensions/blob/main/Apps/W1/APIV2/app/src/pages/APIV2Journals.Page.al
- https://www.kauffmann.nl/2020/03/05/codeunit-apis-in-business-central/
- https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-creating-and-interacting-with-odatav4-unbound-action
