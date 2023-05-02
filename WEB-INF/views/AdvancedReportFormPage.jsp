<%@ page import="webapp.IssuesBean" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Advanced Report Form</title>
        <link rel="stylesheet" href="Style.css">
    </head>
    <body>
        <h1>Specific Issue Details</h1>
<%--        Loading issue to decide which form to use        --%>
        <%  IssuesBean issue = (IssuesBean)request.getSession().getAttribute("Issue"); %>
<%--            Network form    --%>
        <% if (issue.getSubCategory().equalsIgnoreCase("Cannot connect to internet") || issue.getSubCategory().equalsIgnoreCase("Slow internet") || issue.getSubCategory().equalsIgnoreCase("Constant internet dropouts")){ %>
            <form name="advancedReport" method="POST" action="reportIssue" onsubmit="return networkValidation()">
                <label for="browser">Internet Browser currently using: </label>
                <input type="text" name="browser" id="browser"><br>

                <label for="browserVer">Version number of browser: </label>
                <input type="text" name="browserVer" id="browserVer"><br>

                <p>Are external websites effected by this issue?</p>
                <label for="exTrue">True</label>
                <input type="radio" name="externalSites" id="exTrue" value="true"><br>
                <label for="exfalse">False</label>
                <input type="radio" name="externalSites" id="exfalse" value="false"><br>

                <p>If external websites are effected, are internal websites effected too?</p>
                <label for="inTrue">True</label>
                <input type="radio" name="internalSites" id="inTrue" value="true"><br>
                <label for="inFalse">False</label>
                <input type="radio" name="internalSites" id="inFalse" value="false"><br>

                <label for="differentBrowser">Have you tried using a different browser?</label>
                <input type="checkbox" name="differentBrowser" id="differentBrowser" value="true"><br>

                <label for="restartedN">Have you restarted the computer?</label>
                <input type="checkbox" name="restarted" id="restartedN" value="true"><br>

                <label for="errorMessageN">Please enter the error message received here: </label>
                <input type="text" name="errorMessage" id="errorMessageN"><br>

                <p>Is the device connected to the network via cable or wifi?</p>
                <label for="cable">Cable</label>
                <input type="radio" name="cableWifi" id="cable" value="cable"><br>
                <label for="wifi">Wifi</label>
                <input type="radio" name="cableWifi" id="wifi" value="wifi"><br>

                <label for="levelWifiConnection">If the device is connected via wifi, what level of connection is displayed?</label>
                <select name="levelWifiConnection" id="levelWifiConnection"><br>
                    <option value="">Please select...</option>
                    <option value="Strong">Strong</option>
                    <option value="Weak">Weak</option>
                    <option value="None">None</option>
                </select>

                <label for="showConnection">If the device is connected via cable, does the device show it is connected to the network?</label>
                <input type="checkbox" name="showConnection" id="showConnection"><br>

                <label for="numDevicesEffected">How many devices are effected by this issue?</label>
                <input type="number" name="numDevicesEffected" id="numDevicesEffected"><br>

                <input type="submit">
                <input type="hidden" name="location" value="<%=issue.getDescription()%>">
            </form>
<%--            Software report form         --%>
        <% } else if (issue.getSubCategory().equalsIgnoreCase("Application slow to load") || issue.getSubCategory().equalsIgnoreCase("Application won't load")) { %>
            <form name="advancedReport" method="POST" action="reportIssue" onsubmit="return softwareValidation()">
                <label for="problemApplication">What is the name of the problem Application?</label>
                <input type="text" name="problemApplication" id="problemApplication"><br>

                <label for="versionApplication">Version number of application: </label>
                <input type="text" name="versionApplication" id="versionApplication"><br>

                <label for="operatingSystemS">What is the device's current operating system and version?</label>
                <input type="text" name="operatingSystem" id="operatingSystemS"><br>

                <label for="restartedS">Have you restarted the device?</label>
                <input type="checkbox" name="restarted" id="restartedS" value="true"><br>

                <label for="otherSoftware">Is any other software effected? </label>
                <input type="checkbox" name="otherSoftware" id="otherSoftware" value="true"><br>

                <input type="submit">
                <input type="hidden" name="location" value="<%=issue.getDescription()%>">
            </form>
<%--                Computer no power report form       --%>
        <% } else if(issue.getSubCategory().equalsIgnoreCase("Computer has no power")){ %>
            <form name="advancedReport" method="POST" action="reportIssue" onsubmit="return cPowerValidation()">
                <label for="charged">Is the device charged?</label>
                <input type="checkbox" name="charged" id="charged" value="true"><br>

                <label for="makeModelC">What is the make and model of the machine?</label>
                <input type="text" name="makeModel" id="makeModelC"><br>

                <label for="ageC">How old is the machine?</label>
                <input type="number" name="age" id="ageC"><br>

                <label for="sounds">Is the device making any sounds? E.g. Fan sounds, slight clicking?</label>
                <input type="text" name="sounds" id="sounds"><br>

                <label for="startup">Where does the device reach on startup if at all?</label>
                <input type="text" name="startup" id="startup"><br>

                <input type="submit">
                <input type="hidden" name="location" value="<%=issue.getDescription()%>">
            </form>
<%--                Blue screen report form          --%>
        <% } else if(issue.getSubCategory().equalsIgnoreCase("Blue screen")){ %>
            <form name="advancedReport" method="POST" action="reportIssue" onsubmit="return bScreenValidation()">
                <label for="makeModelB">What is the make and model of the machine?</label>
                <input type="text" name="makeModel" id="makeModelB"><br>

                <label for="ageB">How old is the machine?</label>
                <input type="number" name="age" id="ageB"><br>

                <label for="operatingSystem">What is the current operating system of the device and its version?</label>
                <input type="text" name="operatingSystem" id="operatingSystem"><br>

                <label for="priorBlueScreen">Brief explanation of what happened prior to the "Blue Screen" event: </label>
                <input type="text" name="priorBlueScreen" id="priorBlueScreen"><br>

                <label for="response">Does the computer respond to any input?</label>
                <input type="text" name="response" id="response"><br>

                <input type="submit">
                <input type="hidden" name="location" value="<%=issue.getDescription()%>">
            </form>
<%--                Disk drive report form          --%>
        <% } else if(issue.getSubCategory().equalsIgnoreCase("Disk drive issue")){ %>
            <form name="advancedReport" method="POST" action="reportIssue" onsubmit="return dDriveValidation()">
                <label for="makeModel">What is the make and model of the device?</label>
                <input type="text" name="makeModel" id="makeModel"><br>

                <label for="age">How old is the device?</label>
                <input type="number" name="age" id="age"><br>

                <label for="errorMessage">Please enter the error message received here: </label>
                <input type="text" name="errorMessage" id="errorMessage"><br>

                <label for="other">Please enter any other useful information here: </label>
                <textarea name="other" id="other"></textarea><br>

                <input type="submit">
                <input type="hidden" name="location" value="<%=issue.getDescription()%>">
            </form>
<%--            peripherals report form              --%>
        <% } else if(issue.getSubCategory().equalsIgnoreCase("peripherals")){ %>
            <form name="advancedReport" method="POST" action="reportIssue" onsubmit="return peripheralValidation()">
                <label for="peripheralsEffected">What peripheral devices are effected?</label>
                <input type="text" name="peripheralsEffected" id="peripheralsEffected"><br>

                <label for="peripheralConnectionType">What connection type does the device use? E.g. usb, hdmi, etc.: </label>
                <input type="text" name="peripheralConnectionType" id="peripheralConnectionType"><br>

                <label for="peripheralPower">Does the peripheral device have power?</label>
                <input type="checkbox" name="peripheralPower" id="peripheralPower" value="true"><br>

                <input type="submit">
                <input type="hidden" name="location" value="<%=issue.getDescription()%>">
            </form>
<%--                email send/receive report form           --%>
        <% } else if(issue.getSubCategory().equalsIgnoreCase("email send") || issue.getSubCategory().equalsIgnoreCase("email receive")){ %>
            <form name="advancedReport" method="POST" action="reportIssue" onsubmit="return emailValidation()">
                <label for="restarted">Have you restarted the device?</label>
                <input type="checkbox" name="restarted" id="restarted" value="true"><br>

                <label for="emailApp">What email application are you using?</label>
                <input type="text" name="emailApp" id="emailApp"><br>

                <label for="emailAppVersion">What is the version number of the application?</label>
                <input type="text" name="emailAppVersion" id="emailAppVersion"><br>

                <label for="internet">Is the device connected to the internet?</label>
                <input type="checkbox" name="internet" id="internet" value="true"><br>
                <input type="submit">
                <input type="hidden" name="location" value="<%=issue.getDescription()%>">
            </form>
<%--            spam/phishing report form              --%>
        <% } else if(issue.getSubCategory().equalsIgnoreCase("spam phishing email")){ %>
            <form name="advancedReport" method="POST" action="reportIssue" onsubmit="return spamValidation()">
                <label for="spamAddress">Email address of suspect sender: </label>
                <input type="text" name="spamAddress" id="spamAddress"><br>

                <p>What category best fits the reason for reporting this email?</p>
                <label for="malicious">Malicious</label>
                <input type="radio" name="emailCategory" id="malicious" value="malicious"><br>
                <label for="ads">Advertisement</label>
                <input type="radio" name="emailCategory" id="ads" value="advertisement"><br>
                <label for="repeated">Repeated</label>
                <input type="radio" name="emailCategory" id="repeated" value="repeated"><br>

                <input type="submit">
                <input type="hidden" name="location" value="<%=issue.getDescription()%>">
            </form>
<%--            incorrect details report form             --%>
        <% } else if(issue.getSubCategory().equalsIgnoreCase("Incorrect account details")){ %>
            <form name="advancedReport" method="POST" action="reportIssue" onsubmit="return detailsValidation()">
                <label for="details">Please enter each incorrect field followed by its correct detail. E.g. email: john.smith@email.com</label>
                <textarea name="details" id="details"></textarea><br>
                <input type="submit">
                <input type="hidden" name="location" value="<%=issue.getDescription()%>">
            </form>
<%--            password report form             --%>
        <% } else if(issue.getSubCategory().equalsIgnoreCase("Password reset")){ %>
            <form name="advancedReport" method="POST" action="reportIssue" onsubmit="return passwordValidation()">
                <label for="password">What would you like your password set to?</label>
                <input type="text" name="password" id="password"><br>
                <input type="submit">
                <input type="hidden" name="location" value="<%=issue.getDescription()%>">
            </form>
<%--         Warning           --%>
        <% } else { %>
            <h2>Your subcategory doesn't match any if statements in AdvancedReportForm.jsp <br>Your subcategory is: <%= issue.getSubCategory() %></h2>
        <% } %>


    </body>
    <script type="text/javascript" src="script.js"></script>
</html>