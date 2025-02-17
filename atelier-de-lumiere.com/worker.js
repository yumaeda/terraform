addEventListener(
    'fetch', event => {
        event.respondWith(handleRequest(event.request))
    }
)
    
async function handleRequest(request) {
    return new Response(
        'Hello from Cloudflare Worker at atelier-de-lumiere.com!',
        {
            headers: { 'content-type': 'text/plain' },
        }
    )
}
