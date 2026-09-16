# Bible School MVP — Android Student App Design Brief

Design-only. No source code, packages, or Cubit/backend logic were touched to produce this. Source of truth: `PRODUCT.md`.

## 1. Job and audience

- **Who:** ~125 Bible School students, a church community, mixed technical ability, unconfirmed age range (do not assume children/teens/adults). They use this app to check their own record — never to manage anyone else's.
- **Context:** phone, likely at home or right after a session, sometimes with low confidence around apps. No registration — an admin already created their account; they only ever log in.
- **Job to be done:** "What's my status?" — did I attend, what homework is due, what did I answer, what grade did I get. Read-first, light write (answering homework).
- **Visitor mode:** Operate. Expression never outranks the task, state, or a familiar affordance.

## 2. Outcome and proof

- **Primary outcome:** a student opens the app and within seconds sees their name, their attendance, and what homework needs attention — without asking an admin.
- **Proof this app is theirs alone:** every screen is scoped to the logged-in student's own data (RLS at the backend, but the UI should never even gesture at "other students" — no leaderboards, no comparisons, no class-wide lists).
- **Product-specific truths that shape the UI, not just copy:**
  - Attendance is admin-recorded; the student never has an "add attendance" affordance anywhere.
  - Homework is MCQ or Text Answer only — no other question types to design for.
  - A submitted answer stays editable only until it is graded. Grading locks it — once graded, the submission is read-only, with no reopen/regrade workflow in the MVP.
  - There is no aggregate/final grade across assignments — never compute, imply, or display a score spanning multiple assignments. (A single assignment's own total — the sum of its questions' earned/max points — is expected and shown per assignment; see §5.6 Grading model.)

## 3. Selected direction

**World:** a restrained, warm evolution of a personal record-book — not literal pins, cork, torn paper, or stamp illustrations (all explicitly cut for implementation cost), but the underlying idea survives: *this is your own quiet, calm personal record, not a dashboard.* Executed entirely in flat, standard-shape Flutter primitives (Card, Chip, ListTile, LinearProgressIndicator) so it ships fast.

- **Structural thesis:** every piece of the student's record — a book's progress, an attendance tally, an assignment, a grade — is the same visual unit: a calm rounded card with a clear title, a status chip, and one supporting line. Consistency across card types *is* the design system; there is no second visual language to learn per screen.
- **Focal/signature moment:** a graded assignment. No illustrated stamp — instead, a clean score treatment (a numeral pill, e.g. "٨/١٠", set beside the status chip, in `textPrimary` or `primary` — never `critical`/red, since there is no pass/fail formula) is the one moment weight peaks on the page. This pill is always a **derived total** — the sum of each question's earned points over the sum of each question's max points — never a value entered directly anywhere; each question underneath shows its own earned/max pair so the total is legible, not just asserted. Everywhere else stays quiet so this reads clearly when it appears.
- **Sequence:** Login → Home (identity + three entry points) → each section is a flat list of the same card shape, drilling into a detail screen that follows the same card language at larger scale.
- **Implementation consequence:** no custom painting, no illustration budget, no gradients. Cards, chips, dividers, standard form fields, a bottom nav bar, a progress indicator. A competent Flutter dev should be able to build the whole system's shared widgets (`AppCard`, `StatusChip`, `PrimaryButton`, `SectionHeader`) in under a day, then compose screens from them.
- **Approved product icon:** `assets/app_icon.jpg` is the existing, approved application icon. Reuse it wherever product identity is presented, including the Splash screen and, when appropriate, a subtle treatment on Login; do not replace it with a generic open-book or other Material icon. Functional navigation and content actions continue to use standard Material-style icons.

## 4. Scope and boundaries

- **In scope:** the 17 screens/states listed by the user (§6), plus the shared visual system (§5).
- **Fidelity:** production-ready screen specs — layout, hierarchy, states, component behavior — not pixel-perfect mockups or a Figma file.
- **Untouched:** auth/session logic, Supabase schema, Cubit state management, routing — all backend/logic decisions stay with the implementer.
- **Explicit anti-goals (per brief):** no gamification, no illustration/mascot budget, no glassmorphism, no heavy gradients, no heavy animation, no leaderboard/comparison UI, no literal scrapbook/cork/pin/stamp graphics, no invented features beyond PRODUCT.md (no push notifications, no chat, no file uploads unless later confirmed).
- **Platform:** Android only for this surface (per PRODUCT.md — Student App is Android/Flutter, mobile-first). RTL Arabic is the only supported layout direction for this app; no LTR/English variant is in scope here.

## 5. Visual system

### 5.1 Color palette

Restrained strategy: neutrals + one accent, exactly as Operate mode calls for.

| Token | Hex | Use |
|---|---|---|
| `bg` | `#FAF7F1` | App background (warm off-white, not stark white) |
| `surface` | `#FFFFFF` | Card/sheet surfaces |
| `surfaceBorder` | `#ECE5D8` | Hairline card border (used instead of heavy shadow) |
| `textPrimary` | `#2B2620` | Primary text (warm near-black, not pure black) |
| `textSecondary` | `#7A7266` | Secondary/meta text, hints |
| `primary` | `#3E6B5E` | The one accent — links, primary buttons, selected states, "present/submitted/graded" semantics |
| `primaryContainer` | `#E3EEE9` | Light fill behind primary chips/selected rows |
| `critical` | `#A8442E` | Reserved for "absent," destructive/error states, and validation errors — kept rare so it stays meaningful |
| `criticalContainer` | `#F6E4DF` | Light fill behind critical chips/banners |
| `divider` | `#EEE8DC` | List separators |
| `disabled` | `#D9D2C4` | Disabled buttons/fields |

No second accent hue. `critical` (warm red) is reserved strictly for absence, errors, validation, and destructive/irreversible actions — it never appears on a grade, a score, or any normal result, since the MVP has no pass/fail formula. Grades and results use `textPrimary` (neutral) or `primary` (teal) only. Present/submitted/graded/positive states all reuse `primary`. Status is always paired with an icon or label, never color alone (colorblind-safe, and matches how a printed grade sheet actually communicates — check/X, not just red/green).

### 5.2 Arabic typography hierarchy

**Font:** the Android/system Arabic font, resolved. No `google_fonts` package and no bundled custom font files for the MVP — Android's system font stack already falls back to Noto Sans Arabic for Arabic text even under a Latin `fontFamily`, so Arabic renders correctly with zero setup. Hierarchy is carried entirely by size/weight below. Custom typography (e.g. Cairo/Tajawal) can be reconsidered post-delivery.

**Scale** (sp, RTL, right-aligned by default):

| Role | Size / weight | Used for |
|---|---|---|
| Title Large | 22sp / Bold | Screen titles ("الرئيسية", "الواجبات") |
| Title Medium | 17sp / SemiBold | Card titles (book name, assignment title), section headers |
| Body Large | 15sp / Regular | Primary reading content, question text |
| Body Medium | 13sp / Regular | Secondary/meta lines (dates, session counts) |
| Label | 13sp / Medium | Chip text, button labels |
| Caption | 11sp / Regular | Helper text, timestamps, field hints |

Hierarchy comes from size and weight, never from color or decoration — this is also what keeps the system fast to theme with Flutter's `TextTheme`.

### 5.3 Spacing

4pt base grid: `4, 8, 12, 16, 24, 32`.

- Screen horizontal padding: `16`
- Card internal padding: `16`
- Gap between stacked cards: `12`
- Gap between sections: `24`
- Gap between a label and its field: `8`

### 5.4 Border radius

- Cards, sheets, dialogs: `16`
- Buttons, text fields: `12`
- Chips: full/pill (`999`)
- Small inline elements (icon badges): `8`

### 5.5 Elevation

Flat by default: cards use `surfaceBorder` (1px hairline) rather than shadow. Where a shadow is unavoidable (e.g. a bottom sheet, the bottom nav bar), keep it to blur `8`, `~5%` black opacity, `y-offset 2`. No heavy drop shadows, no glass blur.

### 5.6 Core components

**Buttons**
- Primary (filled): `primary` background, white text, height `48–52`, radius `12`. Main actions only: تسجيل الدخول (Log in), إرسال (Submit), حفظ التعديل (Save edit).
- Secondary (outlined or tonal): `primary` outline/text on `surface` or `primaryContainer` fill. Used for: تعديل الإجابة (Edit answer), إعادة المحاولة (Retry).
- Text button: no fill/border, `primary` text. Used for minor actions: تسجيل الخروج (Log out).
- Disabled: `disabled` fill, `textSecondary` text, no elevation.
- One primary action per screen, maximum.

**Text fields**
- Rounded rect, `12` radius, `surfaceBorder` outline, `bg`-tinted fill (slightly recessed from card surface).
- Label above field, right-aligned (RTL), `Body Medium`.
- Focus state: `primary` border, `2px`.
- Error state: `critical` border + `Caption`-size helper text below in `critical`.
- Multiline (text-answer): same treatment, minimum visible height ~4–6 lines, grows with content, placeholder "اكتب إجابتك هنا".

**Cards** (the one reusable shape everything else is built from)
- `surface` background, `16` radius, `surfaceBorder` 1px, `16` padding.
- Structure: title (Title Medium) + one optional status chip top-right (top-left as rendered in RTL) + one supporting meta line (Body Medium/Caption) + optional trailing chevron for navigable cards.
- Tap target is the whole card, not just the title.

**Status chips**
Always icon + label, pill shape, `Label` text. Exactly three lifecycle states for an assignment — no "new/unseen" state:
- لم يبدأ (Not started) — neutral: `divider` fill, `textSecondary` text/icon
- تم التسليم (Submitted) — `primaryContainer` fill, `primary` text/icon (check)
- تم التصحيح (Graded) — `primaryContainer` fill, `primary` text/icon, with the score pill (see §3) placed beside it

Attendance uses its own pair, unrelated to the assignment lifecycle:
- حاضر (Present) — `primaryContainer` fill, `primary` text/icon
- غائب (Absent) — `criticalContainer` fill, `critical` text/icon

**Navigation**
- Bottom navigation bar, 3 destinations: الرئيسية (Home) · الكتب (Books) · الواجبات (Assignments). Attendance is reached from the Home card, not a 4th tab, to keep the bar simple and under Material's comfortable range.
- Top app bar on inner screens: title + back arrow (auto-mirrored by Flutter's RTL `Directionality` — do not hand-place the arrow).
- No hamburger drawer, no tab bar inside screens — one navigation idiom only.

**Book card**
Title (book name) + a slim `LinearProgressIndicator` in `primary` + meta line "X من Y جلسة" (X of Y sessions). No cover art/illustration.

**Attendance summary component**
One card, aggregate-only — no per-session history in the student app (that stays an Admin Dashboard concern). Four figures, RTL-ordered: عدد الحضور (attended count) · عدد الغياب (absent count) · إجمالي الجلسات (total sessions) · النسبة (percentage, emphasized — larger, Bold, `primary`). On narrow width, wrap to two rows of two rather than shrinking type. Optional slim progress bar under the percentage. This is a read-only display component; it never contains any affordance to add/edit attendance, and never lists individual sessions.

**Assignment card**
Title + related book (Body Medium meta) + status chip + posted/due date (Caption). If graded, the score pill sits beside the status chip. Tapping opens the assignment detail.

**Grading model (per-question, derived total)**
Every question — MCQ or Text — carries a `max_points` value set by the admin when building it (see the Admin Dashboard brief). Grading is per question: the admin enters an earned score for each question (e.g. `2` out of a `max_points` of `3`), never a single manually-typed overall grade. The submission's total (the score pill referenced in §3) is always **derived**: sum of earned points over sum of max points across all of the assignment's questions (e.g. `2/3 + 4/5 + 1/2 = 7/10`). The student-facing UI only ever displays this derived total — it never asks the student to compute or enter anything about it. MCQ correct-option marking (see MCQ component below) stays an admin-only answer-key aid and is never shown to the student, before or after grading.

**MCQ component**
Question text (Body Large) at top, options below as full-width selectable rows (map directly to `RadioListTile`): unselected = `surfaceBorder` outline; selected = `primary` border + `primaryContainer` fill, radio dot in `primary`. After grading, the field becomes read-only (no more selection changes — grading locks the submission, see §2). The graded view shows only the student's own selected option (still highlighted as above) plus that question's earned/max points pair (e.g. "٢ / ٢", `Label` size, `textPrimary`) beside the question — it never reveals which option was actually correct; the admin-only correct-option marker has no student-facing equivalent, in the MVP or otherwise. The layout does not shift between submitted and graded states.

**Text-answer component**
Single multiline field styled per §5.6 Text fields. No rich text, no attachments (not in PRODUCT.md scope). After grading, the field renders read-only (per §5.6 Submit/Edit states) with that question's earned/max points pair (e.g. "٤ / ٥") shown beside the question, same treatment as the MCQ component.

**Submit / Edit states**
- Unsubmitted: primary button "إرسال" (Submit), field(s) editable, no chip yet.
- Submitted, ungraded: chip → "تم التسليم"; primary button becomes secondary "تعديل الإجابة" (Edit answer); tapping re-opens the same fields pre-filled with "حفظ التعديل" (Save edit) as the primary action.
- Graded: chip → "تم التصحيح" + the assignment's derived total score pill (sum of all questions' earned/max points, per the Grading model above) at the top, with each individual question also showing its own earned/max pair inline (per the MCQ/Text-answer components above). The submission becomes **read-only** — fields render as static text (not disabled form controls), the edit button is removed entirely, and no reopen/regrade affordance exists anywhere in the MVP.

**Loading state**
Centered `CircularProgressIndicator` in `primary`, no skeleton screens for MVP (skeletons are a valid post-MVP upgrade, not required now — keeps the deadline realistic).

**Empty states**
One small line icon (Material icon, not an illustration) + one line of Arabic copy + optional Caption-size secondary line. E.g. assignments empty: "لا توجد واجبات حالياً" (No assignments right now).

**Error states**
Centered icon + message + "إعادة المحاولة" (Retry) secondary button, or an inline banner (`criticalContainer` background, `critical` text) for field-level/save errors. Never a raw exception string on screen.

## 6. Screens

RTL throughout; all rows/nav/back-arrows mirror automatically under Flutter's `Directionality.rtl` — do not hardcode left/right.

1. **Login** — centered card on `bg`: short title/greeting, username field, password field (with visibility toggle), primary "تسجيل الدخول" button. No "forgot password" or "register" affordance unless PRODUCT.md is updated to include one — there is no registration in this product. Error state: invalid credentials shown as a `Caption`, `critical`-colored line under the password field, not a dialog.
2. **Student Home** — top: name-tag header (see §6.3) inside the top app bar area. Below: three entry cards in a vertical stack — Books, Attendance summary (live numbers, not just a label), Assignments (with a small count of assignments still "Not started," e.g. "٢ لم تبدأ بعد" — a lifecycle count, not a "new" indicator). Bottom nav per §5.6.
3. **Student name and academic year** — not a separate screen; a persistent header element on Home (and optionally repeated smaller on inner screens): name (Title Medium) + "العام الدراسي [year]" (Body Medium/Caption) underneath. Read-only, no edit affordance (students don't manage their own profile per PRODUCT.md's confirmed scope).
4. **Bible Books list** — vertical list of Book cards (§5.6). Ordered as returned by backend (no client-side sort decisions here — implementer/backend concern).
5. **Bible Book detail / progress** — larger version of the book card pattern: title, overall progress bar, then a simple list of sessions/units with a small present/complete marker per row if that data exists; otherwise just the aggregate progress. Do not invent a syllabus structure beyond what the backend provides.
6. **Attendance summary** — the Attendance summary component (§5.6) at full-screen scale: the four aggregate figures (attended, absent, total, percentage), larger type. Aggregate only — no session-by-session list; detailed per-session attendance is an Admin Dashboard concern, out of scope for this app.
7. **Assignments list** — vertical list of Assignment cards (§5.6), most relevant/recent first.
8. **Assignment detail** — title + book context at top, then the question(s) in order, each rendered via the MCQ or Text-answer component per its type, submit/edit button per §5.6 pinned at the bottom.
9. **MCQ question UI** — per §5.6 MCQ component. One question per card if an assignment mixes multiple questions, so long assignments stay scannable.
10. **Text answer UI** — per §5.6 Text-answer component.
11. **Submit homework** — the "unsubmitted" state of §5.6 Submit/Edit states; on tap, show the loading state on the button itself (inline spinner replacing label) rather than a full-screen loader, then transition to submitted state in place — no navigation away, no modal confirmation dialog (keeps it fast and low-friction).
12. **Submitted homework state** — the "submitted, ungraded" state of §5.6.
13. **Edit submitted answers** — same screen as assignment detail, fields pre-filled, "حفظ التعديل" primary action per §5.6. Only reachable while the assignment is still "Submitted" (ungraded) — once graded, this entry point is gone (see screen 14).
14. **Graded homework / grade display** — the "graded," **read-only** state: the assignment's derived total score pill + chip per §5.6 (neutral/`primary` color only, never red), each question showing its own earned/max points pair beneath its answer, fields rendered as static text with no edit affordance, no correct-answer reveal on MCQ questions, and no aggregate/final grade spanning multiple assignments anywhere on this or any screen.
15. **Loading states** — per §5.6, applied to: initial screen loads (centered spinner) and in-place actions (submit/save — inline button spinner, not full-screen).
16. **Empty states** — per §5.6, applied to: no books assigned yet, no assignments yet, (attendance is never "empty" once a student has session history — if a student truly has zero sessions recorded yet, use the same empty-state pattern with copy like "لم تُسجَّل بيانات حضور بعد").
17. **Error states** — per §5.6, applied to: failed login, failed data load (retry button), failed submit (inline banner on the assignment screen, answer preserved locally so nothing is lost).

## 7. Resolved MVP decisions

Previously open, now settled — carried through the whole brief above:

- **Homework editability:** editable only until graded; grading makes a submission read-only; no reopen/regrade workflow.
- **Grading model:** per-question, not a single manually-entered overall grade. Every question carries a `max_points` value; the admin enters an earned score per question; the submission's total is always **derived** (sum of earned ÷ sum of max across the assignment's questions) and never typed in directly. The student view never reveals which MCQ option was correct. See §5.6 Grading model.
- **Attendance:** aggregate only (attended, absent, total, percentage) — no per-session history in the student app; that stays an Admin Dashboard concern.
- **Typography:** Android/system Arabic font only — no `google_fonts`, no bundled custom font, for this MVP.
- **Assignment states:** exactly three lifecycle states — Not started, Submitted, Graded — no separate "new" state or indicator.
- **Color semantics:** warm red (`critical`) reserved for absence, errors, validation, and destructive states only; grades/results always use neutral text or the `primary` teal, never red, since there is no pass/fail formula in the MVP.

No open decisions remain outstanding for this brief.

## 8. Constraints carried from PRODUCT.md

- Arabic-first, RTL-only for this surface; mixed technical ability across the user base — every screen above defaults to the simplest legible layout, not the cleverest one.
- No aggregate/final grade spanning multiple assignments, ever — an assignment's own derived total (sum of its questions' earned/max points) is expected and shown, but grades are never combined across assignments.
- No attendance-editing affordance anywhere in the student app.
- No registration flow.
- Students only ever see their own data — no screen in this brief references another student, a class list, or a comparison.
- Hard deadline September 20, 2026 — every component in §5 is chosen because it maps to a stock Flutter widget (`Card`, `Chip`, `RadioListTile`, `TextFormField`, `LinearProgressIndicator`, `BottomNavigationBar`) with no custom painting or new dependency required.
