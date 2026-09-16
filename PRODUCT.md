# Product

<!-- impeccable:product-schema 1 -->

## Platform

adaptive

## Users

Two roles, both church community members:

- **Students** — roughly 125 people enrolled in the church's Bible School ("students/served members"). Exact age range is not confirmed — do not assume a specific age group (children, teens, or adults) until confirmed. Mixed technical ability.
- **Admins** — roughly 40 church servants who run the Bible School: managing students, academic years, Bible books, sessions, attendance, homework, submissions, and grading.

## Product Purpose

Give the church's Bible School one simple, Arabic-first system to run attendance, homework, and grading. Admins need a fast way to record/edit attendance, create homework, review submitted answers, and enter grades. Students need a simple way to log in and see their own attendance, assignments, submitted answers, and grades without asking an admin for updates. The specific process this replaces today is not confirmed — do not assume paper, spreadsheets, or any specific prior tool.

## Positioning

The single shared record of a student's Bible School standing — attendance, homework, grades — visible and editable by both the student and the servants running the program, instead of living in someone's memory or a scattered set of ad-hoc records.

## Operating Context

One codebase, two genuinely distinct surfaces — not one design language adapted per platform:

- **Admin Dashboard** — Flutter Web, desktop-first, dense operational interface for managing students, academic years, sessions, attendance, homework, submissions, and grading.
- **Student App** — Android (Flutter), mobile-first, simple and focused: view attendance, complete homework, edit submissions, see grades.

Both surfaces share the same backend (Supabase), authentication system, and core data model, and should share one visual identity — but their layout patterns and information density differ deliberately because the usage contexts differ (an admin at a desk vs. a student on a phone).

Arabic RTL is a committed direction for the UI. The current T01 auth skeleton is English/LTR only; Arabic-first localization is planned but not yet built.

Hard deadline: Sunday, September 20, 2026. This is a fast MVP — avoid over-engineering; prefer the simplest correct solution.

## Capabilities and Constraints

- Auth: username + password at the UI (not email); internally mapped to a synthetic email for Supabase Auth (e.g. `mina123` -> `mina123@bibleschool.local`).
- Roles: `admin` and `student`, stored on a `profiles` row linked to `auth.users`; post-login routing happens by role.
- Confirmed domain entities: students, servants/admins, academic years, Bible books, sessions, attendance, homework, submissions, grading. As of this writing only auth/profile scaffolding exists — attendance, homework, and grading are not yet implemented.
- Stack already committed and in place: Flutter, flutter_bloc (Cubit), Supabase (`supabase_flutter`) — see `pubspec.yaml`. Not open for reconsideration.
- Undecided / explicitly unconfirmed: exact student age range; the specific process this system replaces; Arabic RTL implementation details.

## Evidence on Hand

None confirmed yet — no church name/logo/branding, paper forms, or prior system materials were provided. Do not invent placeholder brand assets, sample church names, or sample content in UI work; ask first.

## Product Principles

1. Arabic-first, RTL-ready — this serves an Arabic-speaking congregation; Arabic support is a committed requirement, not an afterthought bolted onto an English design.
2. Two audiences, two surfaces — never force the dense admin dashboard and the simple student app into the same layout just because they share a codebase.
3. Simple over clever — mixed technical ability across ~165 users and a hard deadline mean legibility and directness beat novelty.
4. One shared record — attendance, homework, and grades should feel like the same live record whether an admin edits it or a student views it.
5. Ship the MVP, not the vision — build only what's needed for auth, attendance, homework, and grading; resist speculative features.

## Accessibility & Inclusion

- Arabic RTL support is a committed, near-term requirement (not yet implemented).
- Mixed technical ability among both students and admins — prioritize very simple, clear interfaces over dense or clever ones.
- No confirmed age-specific accessibility needs (e.g. larger touch targets for children) — do not design for a specific age group until the age range is confirmed.
