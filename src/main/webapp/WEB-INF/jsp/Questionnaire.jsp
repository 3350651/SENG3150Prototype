<%@ page import="startUp.UserBean" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <main>
        <header>
           <div id="SkipQuestionnaireButton">
                <form method="POST" action="ModifyAccountDetail" onsubmit="return questionnaire()">
                    <button type="submit" name="skipQuestionnaire" value="skipQuestionnaire">Skip Questionnaire</button>
                </form>
           </div>

            <div id="questionnaire">
                <form method="POST" action="AccountSettings" onsubmit="return questionnaire()">
                    <label for="travelGoals">What are your main goals when travelling?</label>
                    <select id="travelGoals" name="travelGoals[]" multiple>
                      <option value="exploration">Exploring</option>
                      <option value="outdoors">Outdoor Adventures</option>
                      <option value="relaxing">Relaxing</option>
                      <option value="culture">Experiencing New Cultures</option>
                      <option value="landmarks">Visiting landmarks</option>
                    </select>

                    <label for="locations">What sort of locations interest you most?</label>
                    <select id="locations" name="locations[]" multiple>
                        <option value="tropical">Tropical</option>
                        <option value="tourist">Tourist</option>
                        <option value="remote">Remote</option>
                        <option value="snowy">Snowy</option>
                        <option value="cities">Big Cities</option>
                    </select>

                    <label for="valueAdds">Which of these things do you value?</label>
                    <select id="valueAdds" name="valueAdds[]" multiple>
                        <option value="budget">Budget Flights</option>
                        <option value="family">Family Friendly</option>
                        <option value="popular">Popular</option>
                    </select>

                    <button type="submit" name="submitQuestionnaire" value="submitQuestionnaire">Submit</button>
                </form>
            </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>