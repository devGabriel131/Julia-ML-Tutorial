# Book Feedback — Julia ML Competitor

Drop notes/requests here and the daily editor run will treat them as top priority.
Format: one bullet per request. Mark done items with `[x]`.

- Reading-question style (FUTURE questions only — leave 1.3.2 and 1.4.2 as-is, already answered): prefer code-first drills over CS-theory essay prompts. Recast the single-dispatch idea as "write the four `collide` methods for Asteroid/Ship, then show which method `collide(Ship(), Asteroid())` selects and why" instead of "why can single dispatch only fake collide(a,b)". Keep the *concept* (multiple dispatch is the point of the module) but make him type Julia and watch dispatch pick.
- Wording trap to avoid: don't sit a "destructure" question right next to the destructive-`!` material without flagging that destructuring is NON-mutating. Gabriel reasonably read "destructure" as "destructive". When introducing tuple unpacking, state explicitly: `lo, hi = bounds(v)` binds names, leaves the (immutable) tuple untouched — opposite of `!`.
