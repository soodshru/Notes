from flask import Flask
app = Flask (__name__)

@app.route('/')
def root():

@app.route('/<name>')
@app.route('/')
def  generateResponse(name):
        WelcomeName  = "unknown";
        if (name.isupper() and name.isalpha()):
            WelcomeName = name.lower();
        elif (name.islower() and name.isalpha()) :
            WelcomeName = name.upper();
        elif (name.isalpha()):
            WelcomeName = name;
        else :
            newName = ""
            for a in name :
                if a.isalpha() :
                    newName += a
            WelcomeName = newName;
        return "Welcome, "+WelcomeName+", to my CSCB20 website!";


# run the app when app.py is run
if __name__ == '__main__':
    app.run(debug = True)