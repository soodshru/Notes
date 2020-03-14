from flask import Flask, render_template
app = Flask(__name__)
posts=[
	{
		'Name': 'Abbas Attarwala',
		'Date': '9th January, 2019',
		'Topic': 'Computer Science'
	},
	{
		'Name': 'Student2',
		'Date': '10th January, 2019',
		'Topic': 'Computer Science'
	}
]


@app.route('/maps')
def maps():
    return render_template("advancedhome.html",data=posts,title="advanced")

@app.route('/<name>')
def hello(name):
    return '''<html>
    	<head>
    	</head>
    	<body>
    	<b>Hello{0}</b>
    	</body>
    	</html>'''.format(name)

@app.route('/')
def root():
    return render_template('home.html',data=posts, title="abbas")

if __name__ == '__main__':
    app.run()
