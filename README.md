## AWS 람다 함수 코드

```
export const handler = async (event) => {
  const response = {
    statusCode: 200,
    headers: {
      "Content-Type": "text/html",
      "Access-Control-Allow-Origin": "*"
    },
    body: `<html><body>
<script>
  const url = "https://app.pagecall.com/test?voiceonly=true&logLevel=1&build=ryan240102-kick";
  document.addEventListener('DOMContentLoaded', (event) => {
    var iframe = document.createElement('iframe');
    iframe.width = "100%";
    iframe.height = "100%";
    iframe.allow = "microphone";
    iframe.allowusermedia = true;
    iframe.referrerPolicy = "unsafe-url";
    iframe.src = url;
    document.body.appendChild(iframe);
  });
</script>
</body><html/>`,
  };
  return response;
};

```
