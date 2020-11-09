import React, { useState } from 'react';
import styled from 'styled-components';
import { colors } from '@styles/variables';
import { flex, skyblueBoxShadow } from '@styles/utils';
import { SubmitButton, CancelButton } from '@shared';
import { Link, useHistory } from 'react-router-dom';
import { issueService } from '@services';

const MainContainer = styled.div`
  width: calc(70% - 10rem);
  margin-left: 10rem;
  border: 1px solid ${colors.lighterGray};
  border-radius: 5px;
`;

const TitleContainer = styled.div`
  width: calc(100% - 1rem);
  padding: 0.5rem;
`;

const TitleInput = styled.input`
  width: 100%;
  padding: 0.5rem 0 0.5rem 0.5rem;
  border-radius: 5px;
  box-sizing: border-box;
  border: 1px solid ${colors.lighterGray};
  background-color: ${colors.semiWhite};
  outline: 0;
  &:focus {
    ${skyblueBoxShadow}
  }
`;

const TagContainer = styled.div`
  height: 3rem;
  position: relative;
  border-bottom: 1px solid ${colors.lighterGray};
`;

const TagBox = styled.button`
  bottom: -1px;
  left: 0;
  position: absolute;
  margin-left: 0.5rem;
  padding: 0.5rem 1.1rem;
  border-top-left-radius: 5px;
  border-top-right-radius: 5px;
  box-sizing: border-box;
  border: 1px solid ${colors.lighterGray};
  border-bottom-color: white;
  background-color: white;
  font-size: 0.85rem;
  color: ${colors.black6};
  outline: 0;
  z-index: 2;
`;

const ContentContainer = styled.div`
  padding: 0.5rem;
`;

const TextArea = styled.textarea`
  display: flex;
  flex: 1;
  min-width: 100%;
  max-width: 100%;
  height: 12rem;
  min-height: 13rem;
  max-height: 20rem;
  padding: 0.5rem;
  border: 1px solid ${colors.lighterGray};
  border-bottom: 1px dashed ${colors.lighterGray};
  border-top-left-radius: 5px;
  border-top-right-radius: 5px;
  box-sizing: border-box;
  background-color: ${colors.semiWhite};
  outline: 0;
  &:focus {
    ${skyblueBoxShadow}
  }
`;

const FileLabel = styled.label`
  width: 100%;
  padding: 0.4rem;
  display: block;
  font-size: 0.8rem;
  color: ${colors.black6};
  background-color: ${colors.semiWhite};
  border: 1px solid ${colors.lighterGray};
  border-top: 0;
  box-sizing: border-box;
  border-bottom-left-radius: 5px;
  border-bottom-right-radius: 5px;
  cursor: pointer;
`;

const FileSelectInput = styled.input`
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
`;

const ControlBox = styled.div`
  ${flex('space-between', 'center')}
  margin:0.5rem;
`;

const Form = styled.form``;

export default function IssueInputBox() {
  const history = useHistory();

  const [title, setTitle] = useState('');
  const [content, setContent] = useState('');
  const [milestoneNo, setMilestoneNo] = useState(undefined);
  const [issueNos, setIssueNos] = useState([]);
  const [labelNos, setLabelNos] = useState([]);

  const handleTitleChange = ({ target: { value } }) => {
    setTitle(value);
  };

  const handleContentChange = ({ target: { value } }) => {
    setContent(value);
  };

  const handleImageChange = e => {
    const { files } = e.target;
    const [file] = files;
    e.target.value = null;

    const temp = file.name.split('.');
    temp.pop();
    const fileNameWithoutExt = temp.join('');

    const prefex = content.slice(-1) !== '\n' && content.length ? '\n' : '';
    const loadingText = `![Uploading ${file.name}...]()`;

    setContent(content + prefex + loadingText);
    setTimeout(() => {
      const fileUrl = `![${fileNameWithoutExt}](http://~~)`;
      setContent(content + prefex + fileUrl);
    }, 1200);
  };

  const handleSubmit = async e => {
    e.preventDefault();
    if (!title.trim()) {
      alert('제목을 입력해주세요.');
      return;
    }

    if (!content.trim()) {
      alert('내용을 입력해주세요.');
      return;
    }
    try {
      const { status } = await issueService.addIssue({
        title,
        content,
        milestoneNo,
        issueNos,
        labelNos,
      });
      if (status === 200) {
        history.push('/');
      }
    } catch (err) {
      alert('이슈 생성 실패', err.message);
      console.error(err);
    }
  };

  return (
    <MainContainer>
      <Form onSubmit={handleSubmit}>
        <TitleContainer>
          <TitleInput
            name="title"
            placeholder={'Title'}
            onChange={handleTitleChange}
            value={title}
            autoComplete={'off'}
            required
          />
        </TitleContainer>
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
            required
          ></TextArea>
          <FileLabel>
            Attach file by selecting here
            <FileSelectInput name="image" type={'file'} onChange={handleImageChange} />
          </FileLabel>
        </ContentContainer>
        <ControlBox>
          <Link to="/">
            <CancelButton type={'button'}>Cancel</CancelButton>
          </Link>
          <SubmitButton>Submit new issue</SubmitButton>
        </ControlBox>
      </Form>
    </MainContainer>
  );
}
