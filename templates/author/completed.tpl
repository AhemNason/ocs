{**
 * completed.tpl
 *
 * Copyright (c) 2000-2009 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show the details of completed submissions.
 *
 * $Id$
 *}
<div id="submissions">
<table class="listing" width="100%">
	<tr><td class="headseparator" colspan="6">&nbsp;</td></tr>
	<tr valign="bottom" class="heading">
		<td width="5%">{sort_heading key="common.id" heading="id"}</td>
		<td width="5%"><span class="disabled">MM-DD</span><br />{sort_heading key="submissions.submit" heading="submitDate"}</td>
		<td width="5%">{sort_heading key="submissions.track" heading="track"}</td>
		<td width="25%">{sort_heading key="paper.authors" heading="authors"}</td>
		<td width="35%">{sort_heading key="paper.title" heading="title"}</td>
		<td width="25%" align="right">{sort_heading key="common.status" heading="status"}</td>
	</tr>
	<tr><td class="headseparator" colspan="6">&nbsp;</td></tr>
{iterate from=submissions item=submission}
	{assign var="paperId" value=$submission->getPaperId()}
	<tr valign="top">
		<td>{$paperId|escape}</td>
		<td>{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}</td>
		<td>{$submission->getTrackAbbrev()|escape}</td>
		<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		<td><a href="{url op="submission" path=$paperId}" class="action">{$submission->getLocalizedTitle()|strip_unsafe_html|truncate:60:"..."}</a></td>
		<td align="right">
			{assign var="status" value=$submission->getSubmissionStatus()}
			{if $status == SUBMISSION_STATUS_ARCHIVED}{translate key="submissions.archived"}
			{elseif $status==SUBMISSION_STATUS_PUBLISHED}{translate key="submissions.published"}
			{elseif $status==SUBMISSION_STATUS_DECLINED}{translate key="submissions.declined"}
			{/if}
		</td>
	</tr>

	<tr>
		<td colspan="6" class="{if $submissions->eof()}end{/if}separator">&nbsp;</td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="6" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
	<tr>
		<td colspan="6" class="endseparator">&nbsp;</td>
	</tr>
{else}
	<tr>
		<td colspan="4" align="left">{page_info iterator=$submissions}</td>
		<td colspan="2" align="right">{page_links anchor="submissions" name="submissions" iterator=$submissions}</td>
	</tr>
{/if}
</table>
</div>