/** Below code is retrieved from https://community.cloudflare.com/t/connecting-to-google-storage/32350 */

addEventListener(
    'fetch', event => {
        event.respondWith(fetchFromGoogleStorage('YOUR_BUCKET_NAME', event.request));
    }
)

// Get the header of the OAUTH request
const GOOGLE_KEY_HEADER = objectToBase64url(
    {
        alg: 'RS256',
        typ: 'JWT',
    }
)
 
async function fetchFromGoogleStorage(bucketName, request) {
    // Determine the issue and expiration date for the claimset
    const iat = Math.round(Date.now() / 1000);
    const expiration = iat + 3600; // Expires in an hour

    // Generate the claimset payload
    const serviceAccountEmail = 'YOUR SERVICE ACCOUNT EMAIL from Step 1a or 1b below'
    const claimset = objectToBase64url({
        iss: serviceAccountEmail,
        scope: 'https://www.googleapis.com/auth/devstorage.read_write',
        aud: 'https://www.googleapis.com/oauth2/v4/token',
        expiration,
        iat,
    });

    // TODO: use the JSON object from Step 4 below.
    const jwk = {} 

    // Import the Key into a CryptoKey object
    // This will export a private key, only used for signing
    const key = await crypto.subtle.importKey(
        'jwk',
        {
            ...jwk,
            alg: 'RS256',
        },
        {
            name: 'RSASSA-PKCS1-v1_5',
            hash: {
                name: 'SHA-256',
            },
        },
        false,
        ['sign'],
    );

    // Sign the header and claimset 
    const rawToken = await crypto.subtle.sign(
        { name: 'RSASSA-PKCS1-v1_5' },
        key,
        new TextEncoder().encode(`${GOOGLE_KEY_HEADER}.${claimset}`),
    );

    // Convert the token to Base64URL format
    const token = arrayBufferToBase64Url(rawToken);

    // Make the OAUTH request
    const response = await fetch('https://www.googleapis.com/oauth2/v4/token',
        {
            method: 'POST',
            headers: new Headers(
                {
                    'Content-Type': 'application/json',
                }
            ),
            body: JSON.stringify(
                {
                    grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
                    assertion: `${GOOGLE_KEY_HEADER}.${claimset}.${token}`,
                }
            ),
        }
    );

    // Grab the JSON from the response
    const oauth = await response.json()

    const url = new URL(request.url);
    const filePath = url.pathname;
    const gcsUrl = `https://storage.googleapis.com/${bucketName}${filePath}`;

    const responseFromGoogle = fetch(
        gcsUrl,
        {
            method: 'GET',
            headers: new Headers(
                {
                    Authorization: `${oauth.token_type} ${oauth.access_token}`,
                }
            ),
        }
    );
}
  
/**
 * Helper methods for getting things to/from base64url and array buffers
 */
function objectToBase64url(payload) {
    return arrayBufferToBase64Url(
        new TextEncoder().encode(JSON.stringify(payload)),
    );
}

function arrayBufferToBase64Url(buffer) {
    return btoa(String.fromCharCode(...new Uint8Array(buffer)))
        .replace(/=/g, '')
        .replace(/\+/g, '-')
        .replace(/\//g, '_');
}
