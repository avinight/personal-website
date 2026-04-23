const BASE = 'https://api.counterapi.dev/v2/frederick-ms-team-3861/first-counter-3861';

export async function onRequest({ request, env }) {
  const up = new URL(request.url).searchParams.get('up') === '1';
  const url = up ? `${BASE}/up` : BASE;

  try {
    const res = await fetch(url, {
      headers: { Authorization: `Bearer ${env.COUNTERAPI_KEY}` },
    });

    if (!res.ok) {
      return new Response(JSON.stringify({ error: `API ${res.status}` }), {
        status: 502,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    const data = await res.json();
    // counterapi.dev v2 may use 'count' or 'value'
    const count = data.count ?? data.value ?? null;

    return new Response(JSON.stringify({ count }), {
      headers: { 'Content-Type': 'application/json' },
    });
  } catch (e) {
    return new Response(JSON.stringify({ error: String(e) }), {
      status: 502,
      headers: { 'Content-Type': 'application/json' },
    });
  }
}
