const BASE = 'https://api.counterapi.dev/v2/frederick-ms-team-3861/first-counter-3861';

export async function onRequest({ request, env }) {
  const up = new URL(request.url).searchParams.get('up') === '1';
  const url = up ? `${BASE}/up` : BASE;

  try {
    const res = await fetch(url, {
      headers: { Authorization: `Bearer ${env.COUNTERAPI_KEY}` },
    });
    const data = await res.json();
    return new Response(JSON.stringify({ count: data.count }), {
      headers: { 'Content-Type': 'application/json' },
    });
  } catch {
    return new Response(JSON.stringify({ count: null }), {
      status: 502,
      headers: { 'Content-Type': 'application/json' },
    });
  }
}
