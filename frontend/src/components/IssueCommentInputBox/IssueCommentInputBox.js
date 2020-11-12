import React, { useState, useEffect, useRef, useContext } from 'react';
import styled from 'styled-components';
import { Link, useHistory } from 'react-router-dom';
import { debounce } from '@lib/utils';
import { colors } from '@styles/variables';
import { flex } from '@styles/utils';
import { uploadService, commentService } from '@services';
import { SubmitButton, CancelButton } from '@shared';
import { IssueDetailContext } from '@contexts';
import {
  MainContainer,
  TagContainer as IssueTagContainer,
  TagBox,
  ContentContainer,
  TextArea,
  TextCountBox,
  FileLabel,
  FileSelectInput,
  ControlBox as IssueControlBox,
} from '@components/IssueInputBox/IssueInputBox';

const EditContainer = styled(MainContainer)`
  width: 100%;
  margin: 0;
`;

const TagContainer = styled(IssueTagContainer)`
  background-color: ${colors.myCommentColor};
`;

const ControlBox = styled(IssueControlBox)`
  ${flex('flex-end', 'center')}
`;

const UpdateButton = styled(SubmitButton)`
  margin-left: 0.5rem;
`;

export default function IssueCommentInputBox(props) {
  const { setEditMode, commentNo, content: originContent } = props;
  const history = useHistory();
  const { fetchIssueDetails } = useContext(IssueDetailContext);

  const [title, setTitle] = useState('');
  const [content, setContent] = useState(originContent);
  const [debouceClear, setDebouceClear] = useState(undefined);
  const [visiable, setVisable] = useState(false);

  const countRef = useRef();
  const contentRef = useRef();

  useEffect(() => {
    return () => {
      if (debouceClear) {
        clearTimeout(debouceClear);
      }
    };
  });

  const showTextCount = () => {
    setVisable(true);
    countRef.current.textContent = `${contentRef.current.textContent.length} characters`;
    if (debouceClear) {
      clearTimeout(debouceClear);
    }
    setDebouceClear(debounce(() => setVisable(false)));
  };

  const handleTitleChange = ({ target: { value } }) => {
    setTitle(value);
  };

  const handleContentChange = async ({ target: { value } }) => {
    setContent(value);
    if (debouceClear) {
      clearTimeout(debouceClear);
    }
    setDebouceClear(debounce(showTextCount));
  };

  const handleImageChange = async e => {
    const { files } = e.target;
    const [file] = files;
    e.target.value = null;

    const temp = file.name.split('.');
    temp.pop();
    const fileNameWithoutExt = temp.join('');
    const timestamp = new Date().getTime();

    const prefex = content.slice(-1) !== '\n' && content.length ? '\n' : '';
    const loadingText = `![Uploading ${timestamp}_${file.name}...]()`;
    setContent(content + prefex + loadingText);

    try {
      const formData = new FormData();
      formData.append('imgs', file);

      const {
        data: { fileList },
        status,
      } = await uploadService.addImage(formData);
      if (status === 200) {
        const fileUrl = `![${fileNameWithoutExt}](${fileList[0]})`;
        const rep = contentRef.current.textContent.replace(loadingText, fileUrl);
        setContent(rep);
      }
    } catch (err) {
      if (err?.response?.status === 401) {
        history.push('/login');
        return;
      }
      console.error(err);
    }
  };

  const handleSubmit = async e => {
    e.preventDefault();
    if (!content.trim()) {
      alert('내용을 입력해주세요.');
      return;
    }

    try {
      const { status } = await commentService.updateComment({ no: commentNo, content });
      if (status === 200) {
        setEditMode(false);
        fetchIssueDetails();
      }
    } catch (err) {
      if (err?.response?.status === 401) {
        history.push('/login');
      }
      console.error(err);
    }
  };

  const handleCancelClick = () => {
    setEditMode(false);
  };

  return (
    <EditContainer>
      <form onSubmit={handleSubmit}>
        <TagContainer>
          <TagBox>Write</TagBox>
        </TagContainer>
        <ContentContainer>
          <TextArea
            name="content"
            placeholder={'Leave a comment'}
            onChange={handleContentChange}
            value={content}
            autoComplete={'off'}
            ref={contentRef}
            required
          ></TextArea>
          <TextCountBox visiable={visiable} ref={countRef}></TextCountBox>
          <FileLabel>
            Attach file by selecting here
            <FileSelectInput name="image" type={'file'} onChange={handleImageChange} />
          </FileLabel>
        </ContentContainer>
        <ControlBox>
          <CancelButton type={'button'} onClick={handleCancelClick}>
            Cancel
          </CancelButton>
          <UpdateButton>Update comment</UpdateButton>
        </ControlBox>
      </form>
    </EditContainer>
  );
}
