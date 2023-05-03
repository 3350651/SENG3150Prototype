<!DOCTYPE html>
<%//gets all results from statistics servlet to display
    int results[] = (int[]) request.getSession().getAttribute("stat1");
    int results2[] = (int[]) request.getSession().getAttribute("stat2");
    double stressRate = (double) request.getSession().getAttribute("stressRate");%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Statistics</title>
    <link rel="stylesheet" href="Style.css">
</head>
    <body>
<%--        Home button         --%>
    <form name="returnHome" action="issues" method="POST">
        <button type="submit" name="return" value="true">Return to Home</button>
    </form>
    <h1>View Statistics</h1>

    <div>
<%--            First row of table shows first stat and second row second stat           --%>
        <table>
            <tr>
                <th></th>
                <th>Network Issues</th>
                <th>Software Issues</th>
                <th>Hardware Issues</th>
                <th>Email Issues</th>
                <th>Account Issues</th>
            </tr>
            <tr>
                <td>Number of unsolved issues</td>
                <%for(int result: results){%>
                <td><%=result%></td>
                <%}%>
            </tr>
            <tr>
                <td>Number of resolved issues in last 7 days</td>
                <%for(int result2: results2){%>
                <td><%=result2%></td>
                <%}%>
            </tr>
        </table>
    </div>
<%--                Stress rate displayed                  --%>
    <div id="stressRate">
        <p>The total stress rate of the staff has been calculated as: <%=stressRate%></p>
    </div>
    </body>
</html>