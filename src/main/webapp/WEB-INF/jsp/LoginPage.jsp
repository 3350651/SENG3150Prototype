
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<title>Login</title>
	<link rel="stylesheet" href="Style.css">
</head>

<body>
	<main>
		<div id="login">
<%--			Login form					--%>
		<h3>Login</h3>
		<form method = "POST" action="login">
			<label>Email </label>
			<input type="text" name ="email" required></input>

			<br>

			<label>Password </label>
			<input type="password" name ="password" required></input>

			<br>

			<button type="submit" name ="button" value="submit" >Submit</button>
		</form>
		</div>

		<div id="createAccount Container">
		<form method= "POST" action="CreateAccount">
            <button name="createAccount" value="createAccount">Create Account</button>
        </form>

        </div>
	</main>
</body>

</html>
