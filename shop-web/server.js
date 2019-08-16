const path = require('path');
const express = require('express');
const compression = require('compression');
const staticDirectory = '/dist';
const port = 9000;
const app = express();

app.set('port', process.env.PORT || port);
app.use(compression());
app.use('/', express.static(__dirname + staticDirectory, { maxAge: '7d' }));

const versionFile = path.resolve(__dirname + staticDirectory, 'version.json');
app.get(['/version'], (req, res) => {
  res.set({
    'Content-Type': 'application/json'
  });
  res.sendFile(versionFile);
});

app.get('/*', function(req,res){
  // AWS ELB pings this URL to make sure the instance is running
  if ((req.url === '/health') &&
    req.method === 'GET') {
    res.writeHead(200, {
      'Content-Type': 'text/plain',
      'Content-Length': 2,
    });
    res.write('OK');
    res.end();
  }

  // if (req.headers['x-forwarded-proto'] === 'http' && req.headers.host !== 'localhost') {
  //   res.redirect('https://' + req.headers.host + req.url);
  // }

  res.sendFile(__dirname + staticDirectory +'/index.html');
});

app.listen(app.get('port'), function () {
  console.log('localhost listening on port ' + app.get('port'));
});
