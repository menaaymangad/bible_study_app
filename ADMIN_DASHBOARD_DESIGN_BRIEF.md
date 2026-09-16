# Bible School MVP — Flutter Web Admin Dashboard Design Brief

Design-only. No source code, packages, Supabase, Cubit, backend logic, routing, or schema were touched to produce this. Source of truth: `PRODUCT.md`. Shares its visual identity (color, type approach, spacing philosophy) with `STUDENT_APP_DESIGN_BRIEF.md`, but is a separate desktop-first operational surface — it does not reuse the Student App's mobile card/bottom-nav layout patterns.

## 1. Job and audience

- **Who:** ~40 church servants ("admins") who run the Bible School day to day — creating student accounts, taking attendance, and running homework/grading. Mixed technical ability, desk-bound, using a laptop/desktop browser, likely doing this repeatedly (e.g. every session, every week) rather than once.
- **Context:** seated at a computer, often mid-session or right after one, needing to move fast through repetitive data entry (attendance for ~125 students, grading a stack of submissions). This is a tool used *during* operational work, not browsed casually.
- **Job to be done:** "Let me get this data entry done and get back to running the program." Attendance and grading are the highest-frequency, highest-friction tasks; everything else (managing students, academic structure, assignments) is lower-frequency setup/maintenance.
- **Visitor mode:** Operate, uncompromising. Density, scanability, and click-count reduction outrank visual expression everywhere in this surface.

## 2. Outcome and proof

- **Primary outcome:** an admin can take attendance for a full session of ~125 students, or grade a stack of submissions, in a few minutes without dialogs interrupting each individual action.
- **Proof this is an operational tool, not a shrunk-down student view:** tables and matrices as the default layout for anything list-shaped; forms are dense and keyboard-friendly; simple sub-entities save inline via dialogs rather than full page navigations; nothing here is a card grid.
- **Product-specific truths that shape the UI, not just copy:**
  - Students never register themselves — every student account is admin-created, so Add Student is a first-class, frequent action, not a rare edge case.
  - Attendance is per **Session**, not per chapter/book — the matrix's columns are sessions.
  - Grading is per question, and the submission's total is always derived: every question (MCQ or Text) carries a `max_points` value, the admin enters an earned score per question, and the total (sum of earned ÷ sum of max) is computed automatically — never a second manually-typed overall grade, and never an aggregate/final grade across assignments.
  - Once an admin grades a submission, only the **student's** view locks read-only — the admin can still revise any question's score afterward, and the total recomputes automatically.
  - MCQ "correct option" marking is a private answer-key aid for the admin while grading; it never auto-scores anything.

## 3. Selected direction

**Visual authority:** identical tokens and restraint policy to the Student App (`STUDENT_APP_DESIGN_BRIEF.md` §5.1) — same cream background, white surfaces, warm near-black text, one muted-teal accent, warm red reserved for absence/errors/destructive actions, no gradients, no glassmorphism, no decoration. What changes is *density and structure*, not color or tone.

- **Structural thesis:** the unit of this UI is the **table row**, not the card. Every list-shaped screen (students, academic years, books, sessions, assignments, submissions) is a dense data table with inline row actions. The one deliberate exception is the attendance matrix, which is a two-dimensional grid (students × sessions) rather than a one-dimensional table, because that is the actual shape of the data.
- **Focal/signature moment:** the attendance matrix. It is the screen an admin opens most often and the one place density, speed, and clarity are non-negotiable — a frozen name column, a frozen session-header row, and one-click cycling cells, so 125 students × a semester of sessions stays operable without a single dialog.
- **Sequence:** Login → Shell (sidebar + content) → each domain area is List → (dialog or page) Add/Edit → Details, with Attendance and Grading breaking that pattern deliberately because they are continuous-entry workflows, not CRUD forms.
- **Implementation consequence:** two form patterns only — a **dialog** for simple, single-entity forms (Student, Academic Year, Bible Book, Session — a handful of fields, saved in one shot), and a **dedicated page** for the one genuinely complex form (Assignment + its questions). No third pattern. Everything else composes from one table component, one dialog shell, one status-chip component, and standard Flutter form fields.

## 4. Scope and boundaries

- **In scope:** the 28 areas listed by the user, plus the shared visual system (§5) they're built from.
- **Fidelity:** production-ready screen specs — layout, hierarchy, states, component behavior, interaction rules — not pixel-perfect mockups or a Figma file.
- **Untouched:** Supabase schema, Cubit state management, routing, auth logic — all backend/logic decisions stay with the implementer. (`academic_years` and `profiles` tables already exist per `supabase/schema.sql`; this brief does not propose schema changes, though the Sessions/Assignments/Attendance/Submissions areas below imply tables not yet in that file — those are the implementer's schema decisions, not this brief's.)
- **Explicit anti-goals (per brief):** no charts/analytics beyond simple actionable counts, no complex permissions/roles beyond admin/student, no notifications, no settings pages, no speculative features, no heavy animation, no reuse of the Student App's mobile card/bottom-nav patterns.
- **Platform:** Flutter Web, desktop-first, Arabic RTL only for this surface (no LTR variant in scope). Primary target ≥1280px width; graceful icon-rail sidebar collapse down to ~1024px is a reasonable minimum — this surface is not designed for phone widths.

## 5. Visual system

### 5.1 Color palette (identical to Student App — reproduced for implementer convenience)

| Token | Hex | Use |
|---|---|---|
| `bg` | `#FAF7F1` | App/page background |
| `surface` | `#FFFFFF` | Sidebar, table surfaces, cards, dialogs |
| `surfaceBorder` | `#ECE5D8` | Hairline borders — table row dividers, panel outlines, sidebar divider |
| `textPrimary` | `#2B2620` | Primary text |
| `textSecondary` | `#7A7266` | Secondary/meta text, table header labels, placeholders |
| `primary` | `#3E6B5E` | Accent — links, primary buttons, active nav item, "present" cells, selected states |
| `primaryContainer` | `#E3EEE9` | Light fill behind primary chips, active nav row, present cells |
| `critical` | `#A8442E` | Absence, errors, destructive actions only |
| `criticalContainer` | `#F6E4DF` | Light fill behind critical chips/banners, absent cells |
| `divider` | `#EEE8DC` | List/table separators |
| `disabled` | `#D9D2C4` | Disabled buttons/fields |
| `unmarkedFill` | `#F3EFE6` | New token, admin-only: neutral fill for attendance cells not yet recorded (a step below `bg`, distinct from both `primaryContainer` and `criticalContainer`) |

Same semantic discipline as the Student App: `critical` never appears on a grade or a normal result — only on absence and destructive/error states. Status is always icon + label or icon + text, never color alone.

### 5.2 Desktop Arabic typography hierarchy

Same font strategy as the Student App: the system Arabic font stack (no `google_fonts`, no bundled font). Hierarchy carried by size/weight, right-aligned by default (RTL). Sizes are tuned for a denser desktop viewing distance, not a direct port of the mobile scale:

| Role | Size / weight | Used for |
|---|---|---|
| Page Title | 22px / Bold | Page header title ("الطلاب", "الحضور") |
| Panel/Section Title | 16px / SemiBold | Dialog titles, detail-page section headers |
| Table Header Label | 13px / Medium, `textSecondary` | Column headers |
| Table Cell / Body | 14px / Regular | Table cell content, form field values |
| Meta / Secondary | 12px / Regular, `textSecondary` | Row meta, timestamps, counts |
| Label | 13px / Medium | Buttons, chips, form field labels |
| Caption | 11px / Regular | Helper text, validation messages |

### 5.3 Spacing

4pt base grid, wider than mobile to suit desktop viewports: `4, 8, 12, 16, 24, 32, 40`.

- Page horizontal padding: `32`
- Sidebar width: `240` (expanded), `64` (collapsed icon rail)
- Standard table row height: `44`
- Attendance matrix row height: `36` (denser — optimized for scanning many rows)
- Gap between page header and content: `24`
- Gap between form fields: `16`; label-to-field gap: `6`
- Dialog padding: `24`

### 5.4 Border radius

- Panels, cards, dialogs: `12`
- Buttons, inputs, dropdowns: `8`
- Chips: pill (`999`)
- Attendance matrix cells: `4` (subtle, keeps the grid feeling like a grid, not a stack of cards)

### 5.5 Elevation

Flat by default, same as Student App: `surfaceBorder` hairlines instead of shadow for tables/panels/sidebar. Dialogs get a scrim (`rgba(43,38,32,0.4)`) plus a light shadow (blur `16`, ~`8%` black, y-offset `4`) since they sit above a busy table underneath and need real separation.

### 5.6 Core components

**Sidebar (persistent, right-anchored under RTL)**
- Fixed `240`px panel, `surface` background, `surfaceBorder` divider on its inner (left) edge.
- Top: app/org label as plain text (no invented logo/branding — none confirmed per PRODUCT.md).
- Grouped nav list: الرئيسية (Dashboard) standalone at top; group "الطلاب" (Students); group "الهيكل الأكاديمي" (Academic Years, Bible Books, Sessions); "الحضور" (Attendance) standalone; group "الواجبات" (Assignments, Submissions). Group labels are small `Caption`/`textSecondary` text, not clickable.
- Nav item: icon + label, `44`px tall row. Active state: `primaryContainer` fill, `primary` text/icon, a `3`px `primary` accent bar on the item's inner edge. Inactive: `textPrimary` text, transparent.
- Bottom-pinned: admin's display name (`Body`/`textSecondary`) + text-button "تسجيل الخروج" (Log out) — no confirmation dialog on logout (non-destructive).
- Collapse rule: below ~1024px width, collapses to a `64`px icon-only rail (icons + tooltips on hover), never fully hides — desktop-first means this is a floor, not a phone breakpoint.

**Top bar / page header (per page, not a persistent app bar)**
- Row at the top of the content area: Page Title (right-aligned per RTL) + primary action button, if the page has one, placed at the row's opposite (left) end. Optional breadcrumb below the title on nested pages (e.g. "الطلاب / أحمد سمير" on Student Details).
- No global search, no notification bell, no settings icon — none of those are in scope.

**Table (the default list component)**
- `surface` background, `surfaceBorder` outline, `surfaceBorder` row dividers, header row in `Table Header Label` style with a slightly heavier `surfaceBorder` bottom rule.
- Row height `44`, hover state = subtle `bg`-tinted row background, whole row clickable when the row opens a details view; explicit icon-buttons at the row's end for Edit/Delete/secondary actions so click targets stay obvious even on a clickable row.
- Above the table: a control row with search field (left, RTL-mirrored to visually lead) + one or two filter dropdowns (e.g. Academic Year) + primary "+ إضافة" action button, all `40`px tall.
- No pagination for the data volumes in scope (largest table is ~125 students) — a plain scrollable table with a "X من Y" total count label is sufficient; skip building pagination controls.

**Dialog (for simple single-entity forms)**
- Centered, `480`px wide typical, `surface`, `12` radius, scrim behind. Title (`Panel Title`) + close icon (top-left, RTL) + form fields + footer action row (Cancel as text/secondary button, Save as primary button — outer/inner order follows Flutter's standard `AlertDialog` action layout under RTL `Directionality`; do not hand-order the buttons).
- Used for: Add/Edit Student, Add/Edit Academic Year, Add/Edit Bible Book, Add/Edit Session, all confirmation dialogs.

**Buttons**
- Primary (filled): `primary` bg, white text, height `40`, radius `8`. One per page/dialog for the main action.
- Secondary (outlined/tonal): `primary` outline or `primaryContainer` fill. Cancel, secondary actions.
- Destructive: same shape as primary, `critical` bg — reserved for delete/irreversible confirmations only.
- Icon button: `32`x`32` tap target, for inline row actions (edit/delete pencils/trash in tables).
- Text button: no fill, `primary` text — logout, "تعديل" links, minor actions.

**Text fields / dropdowns**
- Same visual treatment as Student App (`12`px→`8`px radius on desktop, `surfaceBorder` outline, label above, RTL right-aligned), height `40`. `DropdownButtonFormField`-shaped selects for Academic Year/Bible Book pickers. Password fields include a visibility toggle.

**Status chips**
Same pill shape as Student App, `Label` text, icon + text always:
- تم التسليم (Submitted) — `primaryContainer`/`primary`
- بانتظار التصحيح (Awaiting grading) — neutral `unmarkedFill`/`textSecondary` (distinct from Submitted so admins can scan for what still needs them)
- تم التصحيح (Graded) — `primaryContainer`/`primary`, the derived total (sum of the assignment's per-question earned/max points) shown beside it as a numeral pill (same treatment as the Student App's score pill)
- حاضر (Present) / غائب (Absent) — same pair as Student App, plus a third **لم يُسجَّل (Unmarked)** chip in `unmarkedFill`/`textSecondary` used wherever attendance status needs to be summarized outside the matrix (e.g. a session's row in the Sessions list showing "٣ غير مسجَّل" (3 unmarked)).

**Grading model (per-question, derived total)**
Every question built in the Assignment builder (§19–21) carries a required numeric `max_points` value set by the admin — MCQ and Text questions both. During grading (§24), the admin enters an earned score per question rather than one manually-typed overall grade; the field enforces `earned ≤ max_points` inline (validation error per §5.6 Error states if the admin types over the ceiling). The submission's total — shown as the numeral pill on the Graded status chip and at the top of Student Submission Details — is always **derived**: sum of every question's earned points over sum of every question's max points (e.g. `2/3 + 4/5 + 1/2 = 7/10`). There is no separate field for the total anywhere in the UI; it is computed and displayed, never entered.

**Empty states**
Centered icon + one line of Arabic copy +, unlike the Student App, the fixing action front and center as a primary button when the admin can act on the emptiness (e.g. empty Students table → "لا يوجد طلاب بعد" + "+ إضافة طالب" button in the empty state itself, not just in the header).

**Loading states**
Centered `CircularProgressIndicator` for full-page/table loads; small inline spinners for cell-level or row-level async saves (attendance cell, grade save) — never a full-page blocker for a single-cell edit.

**Error states**
Inline banner (`criticalContainer` bg, `critical` text, small icon) at the top of the page/dialog for load/save failures, with a "إعادة المحاولة" (Retry) button where applicable. Field-level errors: `critical`-border field + `Caption` message below. Never a raw exception string on screen.

**Confirmation dialogs**
Standard dialog shell (§ above), used only for irreversible/destructive actions: delete student, delete academic year/book/session, delete a question from the assignment builder, discard unsaved assignment changes on navigate-away. Title states the action as a question ("حذف الطالب؟"), one line states the consequence, Cancel + destructive-red Confirm. Never used for routine saves (attendance, grading, simple form submits all save without a confirmation step).

## 6. The attendance matrix (critical workflow — spec in full)

**Layout:** a dedicated page reached from the "الحضور" sidebar item. Page header: title + Academic Year filter dropdown + Bible Book filter dropdown (sessions are scoped to a book, per §7) + a student search box that filters/highlights matching rows without leaving the matrix.

**Grid structure:**
- Rows = students in the selected Academic Year (~125 max). Columns = sessions for the selected Academic Year + Bible Book, ordered so the **most recent session sits closest to the frozen name column** (i.e., nearest the reading start in RTL) — the admin's most common target (today's session) is reached with the least scrolling; older sessions extend outward and require scrolling, but remain fully editable.
- The student-name column stays visually fixed while the grid scrolls horizontally through sessions. The session-header row stays visually fixed while the grid scrolls vertically through students. Both freeze simultaneously (a frozen corner), so a student's name and the session date are always visible no matter how far scrolled. Implementer's choice how to build this with zero new dependencies (e.g. synced `ScrollController`s across a fixed name-column `ListView` and a 2D scrollable grid) — flagged as the one place in this surface where getting the scroll mechanics right matters more than which specific widget produces it.
- Row height `36`, name column width `~200`px, each session column `~56`px wide (fits a short date label, e.g. "٢٣/٩") — dense enough that a laptop screen shows a useful number of sessions without scrolling for a typical month.

**Cell states and interaction:**
- Three states: **لم يُسجَّل / Unmarked** (`unmarkedFill` bg, no icon — the default for any student/session pair with no recorded attendance), **حاضر / Present** (`primaryContainer` bg, `primary` check icon), **غائب / Absent** (`criticalContainer` bg, `critical` × icon).
- Single click cycles a cell: Unmarked → Present → Absent → Unmarked. No dialog, no confirmation, ever — the click *is* the save (small inline spinner-to-checkmark flash on the cell during the async write, per §5.6 loading states).
- Each session column header carries a small "تحديد الكل حاضر" (mark all present) icon-button. Clicking it sets every currently **Unmarked** cell in that column to Present — it never overwrites a cell an admin already explicitly set to Present or Absent, so a bulk pass never clobbers a manually recorded absence. This is the fast path for the common case (most students attend); admins then click individual exceptions to Absent.
- Historical columns behave identically to the current session — no separate "locked" state for past sessions. Attendance is always editable, per the user's requirement.
- Unmarked cells never count toward a student's present/absent percentage anywhere in the system (Student App aggregate, Student Details screen) until explicitly set — this is a data-semantics requirement, not just a visual one, and should be called out to whoever implements the aggregation query.

**Legend:** a small always-visible key near the page header (three swatches: dash/Unmarked, check/Present, ×/Absent) so the color coding needs no memorization on day one.

## 7. Screens

RTL throughout; sidebar and all row/nav/icon mirroring follow Flutter's `Directionality.rtl` automatically — do not hand-place edges.

1. **Admin Login** — centered `440`px panel on `bg` (the one screen where a centered-card pattern is appropriate regardless of platform): app label, username field, password field with visibility toggle, primary "تسجيل الدخول" button. Invalid-credentials error as a `Caption`/`critical` line under the password field, not a dialog.
2. **Main Admin Shell** — persistent right-anchored sidebar (§5.6) + per-page top bar (§5.6) + scrollable content area. Content has no enforced max-width — tables and the attendance matrix use the full available width.
3. **Sidebar navigation** — per §5.6, grouped list, collapses to icon rail below ~1024px.
4. **Dashboard/Home** — page header "الرئيسية" with no primary action. Below: a row of plain stat tiles (not charts) — total students, total sessions this academic year, submissions awaiting grading — each tile clickable and navigating to the relevant filtered list (e.g. the awaiting-grading tile jumps straight to Submissions filtered to "بانتظار التصحيح"). Below that: quick-action buttons for the two highest-frequency tasks — "تسجيل الحضور" (Take Attendance) and "إضافة طالب" (Add Student). No charts, no trends, no vanity metrics.
5. **Students list** — table per §5.6: Name, Username, Academic Year, row actions (Edit, view via row click). Control row: search + Academic Year filter + "+ إضافة طالب".
6. **Student search** — the search field in the Students list control row, live-filtering by name/username; the same search pattern (and component) reused inside the attendance matrix for jumping to a student row.
7. **Add Student** — dialog (§5.6). Fields: Name, Username, Password (with visibility toggle), Academic Year (dropdown). Duplicate-username errors surface as a field-level error under Username, not a banner.
8. **Edit Student** — same dialog prefilled. Password field is optional here with helper caption "اتركه فارغاً لعدم التغيير" (leave blank to keep unchanged). A "حذف الطالب" destructive text-button in the dialog footer opens the delete confirmation dialog (§5.6/§28).
9. **Student Details** — dedicated page (row click from Students list). Header: name, username, Academic Year chip, Edit button. Two sections below: an Attendance summary (aggregate figures plus, unlike the Student App, a scrollable per-session history list — this is the admin-side complement to the app's aggregate-only view) and an Assignments/Submissions history for that student (title, status chip, grade if graded).
10. **Academic Years list** — table: Name, student count, Bible Book count, created date, row actions. Control row: "+ إضافة عام دراسي".
11. **Add/Edit Academic Year** — dialog. Single field: Name (matches the existing `academic_years` schema — no start/end dates, since none are confirmed in PRODUCT.md).
12. **Bible Books list** — table: Name, assigned Academic Years count, row actions. Control row: "+ إضافة كتاب".
13. **Add/Edit Bible Book** — dialog. Single field: Name (no additional metadata — not confirmed as needed).
14. **Assign Bible Books to Academic Years** — a section within Academic Year Details (opened from the Academic Years list row): "الكتب المخصصة لهذا العام" — a checklist of all Bible Books with a checkbox per book. Toggling a checkbox saves the assignment immediately (no separate Save button, no dialog) — consistent with the surface's no-dialog-per-toggle philosophy used in the attendance matrix.
15. **Sessions list** — table: Date, Academic Year, Bible Book, an Unmarked-count chip if the session has unrecorded students, row actions (Edit, "تسجيل الحضور" shortcut that opens the Attendance matrix pre-filtered to this session's year/book). Control row: Academic Year filter + Bible Book filter + "+ إضافة جلسة", sorted by date descending.
16. **Add/Edit Session** — dialog. Fields: Academic Year (dropdown), Bible Book (dropdown, filtered to books assigned to the chosen year), Date (date picker), optional short title/label field.
17. **Attendance Management** — full spec in §6.
18. **Assignments list** — table: Title, Academic Year, Bible Book, question count, submission count, awaiting-grading count (as a chip), row actions (Edit, "عرض التسليمات" View Submissions). Control row: Academic Year/Bible Book filters + "+ إنشاء واجب" (opens the dedicated builder page, not a dialog — this is the one complex form in the surface).
19. **Create/Edit Assignment** — dedicated page. Header fields: Title, Academic Year (dropdown), Bible Book (dropdown, filtered by year). Below: a "الأسئلة" section listing added questions as compact rows (type badge MCQ/Text, question text preview, max-points value, drag-handle or up/down reorder, edit/delete icon buttons) with two add buttons at the bottom of the list: "+ سؤال اختيار من متعدد" and "+ سؤال نصي", each expanding an inline builder card (§20/§21) in place — the whole assignment stays on one page and one continuous scroll. Sticky footer bar with a primary "حفظ الواجب" (Save Assignment) button.
20. **MCQ Question Builder** — inline expandable card within the assignment page: multiline question-text field; a dynamic options list (each option = text field + a correctness radio marker, reference-only per §2/confirmed decision, + a remove "×" icon), "+ إضافة خيار" to add another option (minimum 2 options enforced), required numeric "الدرجة القصوى" (max points) field, collapse/delete icons on the card itself.
21. **Text Question Builder** — inline expandable card: multiline question-text field, required numeric "الدرجة القصوى" (max points) field.
22. **Submissions list** — table, reached via an Assignment's "عرض التسليمات" row action, scoped to that assignment: Student Name, submitted date, status chip (Submitted / Awaiting grading — the MVP has no separate "not started" row here since ungraded and unsubmitted aren't the same list), Total Grade — derived, sum of question scores (if graded), row action "فتح" (Open) to Student Submission Details. Control row: status filter dropdown + student-name search.
23. **Student Submission Details** — dedicated page: header (student name, assignment title, submitted date, and — once every question is scored — the derived total pill). Each question rendered in order: the student's answer read-only (MCQ shows the selected option highlighted plus a subtle correct-answer marker for the admin's reference, per confirmed decision, never used to auto-score; Text shows the free-text answer in a plain read-only block), with that question's grading control (§24) inline beside it rather than one grading panel at the bottom.
24. **Grading** — inline with each question in Student Submission Details, not a separate page/dialog: beside each question, a small numeric "الدرجة" (Score) field pre-labeled with that question's max (e.g. "___ / ٣"), validated so the entered value cannot exceed the question's max points (inline error per §5.6 Error states if it does). Each field saves independently on blur/enter — no dialog, no separate per-question save button, consistent with the surface's no-dialog-per-change philosophy. A running derived total ("المجموع: ٧ / ١٠") is pinned at the top of the page beside the header and updates live as each question is scored — there is no field for it, since it is always computed, never entered directly. Once every question has a score, the status chip flips to "تم التصحيح". The fields stay editable indefinitely on the admin side (only the *student's* view locks, per PRODUCT.md), so an admin can revise any question's score later and the total recomputes automatically, with no special "unlock" step.
25. **Loading states** — per §5.6: centered spinner for full page/table loads; inline cell/row-level spinners for attendance-cell and grade saves; sticky-footer "حفظ" buttons show an inline spinner replacing their label during save.
26. **Empty states** — per §5.6, applied with a front-and-center primary action wherever the admin can fix the emptiness: no students yet, no academic years yet, no Bible Books yet, no sessions yet for the selected year/book, no assignments yet, no submissions yet for an assignment.
27. **Error states** — per §5.6: inline banner + retry for failed loads; field-level captions for validation; toast-free failure indication on attendance-cell/grade saves (cell/field reverts with a brief `critical`-tinted flash plus a small retry affordance, since a blocking banner would be disproportionate to a single-cell failure).
28. **Confirmation dialogs** — per §5.6, used only for: delete student, delete academic year, delete Bible Book (only if unused by any session — otherwise block with an explanatory inline message, not a dialog), delete session, delete a question in the assignment builder, discard unsaved assignment changes on navigate-away.

## 8. States and ranges

- Students: realistic max ~125 per academic year; design tables and the matrix for this ceiling without pagination.
- Sessions per Academic Year + Bible Book: could reach 30–50+ over a school year — the matrix must stay smooth scrolling horizontally at this column count; if performance requires it, the implementer should virtualize off-screen columns/rows rather than rendering all cells eagerly.
- Academic Years and Bible Books: small counts (low single digits to ~10) — plain dropdowns are sufficient, no need for searchable selects.
- Assignments per Bible Book: modest (a handful to a few dozen) — no pagination needed on the Assignments list either.
- Submissions per Assignment: up to ~125 (one per student) — same table pattern as Students, no pagination.

## 9. Resolved MVP decisions

Confirmed during shaping, carried through the brief above:

- **Attendance default:** every cell starts **Unmarked**, never auto-counted as present or absent; a per-column "mark all present" bulk action only fills currently-unmarked cells, so it never overwrites a manually recorded absence. Unmarked cells are excluded from attendance percentages everywhere in the system.
- **Grading granularity:** per-question, not a single manually-entered overall grade. Every question (MCQ or Text) carries a required `max_points` value set at build time; the admin enters an earned score per question during grading; the submission's total is always **derived** (sum of earned ÷ sum of max across the assignment's questions) and never typed in directly. No aggregate spans multiple assignments, ever.
- **MCQ correctness:** marking an option "correct" is a private reference for the admin while grading; it never auto-scores or auto-suggests a grade. The student view never reveals which option was correct.
- **Session scope:** a Session belongs to a specific Bible Book (within an Academic Year) — Add/Edit Session includes both an Academic Year and a Bible Book picker, and Sessions/Attendance can be filtered by book.
- **Form pattern:** dialogs for simple single-entity forms (Student, Academic Year, Bible Book, Session); a dedicated page only for the Assignment builder, since it is the one multi-part form in the surface.
- **Grading lock is one-sided:** grading (scoring each question) locks the submission read-only for the student; the admin can keep revising any question's score afterward — the derived total recomputes automatically — with no unlock step.

## 10. Constraints carried from PRODUCT.md

- Arabic-first, RTL-only for this surface; mixed technical ability among admins — favor obvious, labeled controls over icon-only affordances except in the few places noted (row action icons, matrix bulk-action icon), which should carry tooltips.
- No aggregate/final grade spanning multiple assignments, ever — an assignment's own derived total (sum of its questions' earned/max points) is expected and shown, but grades are never combined across assignments.
- No public registration — Add Student is the only account-creation path in the product.
- No charts, no analytics beyond the plain actionable counts on the Dashboard.
- No notifications, no settings pages.
- Hard deadline September 20, 2026 — every component above maps to standard Flutter Web-friendly widgets (`Table`/`DataTable`-shaped rows, `TextFormField`, `DropdownButtonFormField`, `AlertDialog`, `ListView`, plain `Icon` buttons) with no new package required to build this brief; the only open technical question flagged (not a design decision) is how the implementer chooses to build the matrix's synced frozen row/column scrolling.
